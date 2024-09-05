import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/bloc/util/file_utils.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CourseLecturesScreen extends StatefulWidget {
  const CourseLecturesScreen({super.key, required this.courseId});

  final int courseId;

  @override
  _CourseLecturesScreenState createState() => _CourseLecturesScreenState();
}

class _CourseLecturesScreenState extends State<CourseLecturesScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, state) {
        return switch (state) {
          CourseListLoadingState() => const Center(
            child: CircularProgressIndicator(),
          ),
          CourseListErrorState(error: var err) => Center(
            child: Text(err),
          ),
          // Check to see if this anonymous function needs to be called
          CourseListLoadedState(courses: var courses) => () {
            FullCourseRun courseRun = courses[widget.courseId]!;

            // final playerWidget = Chewie(
            //   controller: _chewieController!,
            // );

            return MultiBlocProvider(
              providers: [
                BlocProvider<LectureBloc>(
                  create: (context) => LectureBloc(
                    context.read<CourseRepository>(),
                  )..add(LectureListLoadEvent(courseRun.course.coursenum)),
                ),
              ],
              child: BlocBuilder<LectureBloc, LectureListState>(
                builder: (context, state) {
                  return switch (state) {
                    LectureListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    LectureListErrorState(error: var err) => Center(
                      child: Text(err),
                    ),
                    LectureListLoadedState(lectures: var lectures) => ListView(
                      padding: const EdgeInsets.all(10),
                      children: lectures.map((lecture) => LectureTile(courseRun: courseRun, lecture: lecture)).toList(),
                    ),
                  };
                },
              ),
            );
          }(),
        };
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   if (_videoPlayerController != null) {
  //     return;
  //   }
  //
  //   findLectures().then((lectures) {
  //     print(
  //         "--------------------------------- Lectures -------------------------------------");
  //     print("Found ${lectures.length} lectures");
  //     for (var lecture in lectures) {
  //       print(lecture.toJson());
  //       print("");
  //     }
  //
  //     // final videoUri = Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
  //     final videoUri =
  //         Uri.parse(lectures[0].archiveUrl).replace(scheme: "https");
  //     print("Video URI");
  //     print(videoUri);
  //
  //     final videoPlayerController = VideoPlayerController.networkUrl(videoUri);
  //
  //     videoPlayerController.initialize().then((_) {
  //       final chewieController = ChewieController(
  //         videoPlayerController: videoPlayerController,
  //         // autoPlay: true,
  //         looping: true,
  //       );
  //
  //       setState(() {
  //         _videoPlayerController = videoPlayerController;
  //         _chewieController = chewieController;
  //       });
  //     });
  //   });
  // }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }

    if (_chewieController != null) {
      _chewieController!.dispose();
    }

    super.dispose();
  }

  Future<List<LectureFile>> findLectures() async {
    final files = searchFilesAndPattern((await getDownloadsDirectory())!,
        'data.json', '"learning_resource_types": ["Lecture Videos"');

    files.sort((a, b) => a.path.compareTo(b.path));

    return files.map((file) {
      final String fileContents = file.readAsStringSync();
      final Map<String, dynamic> fileJson = json.decode(fileContents);
      return LectureFile.fromJson(fileJson);
    }).toList();
  }
}
