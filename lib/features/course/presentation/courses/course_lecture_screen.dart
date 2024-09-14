import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_header.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';

class CourseLectureScreen extends StatefulWidget {
  final String coursenum;
  final String lectureKey;

  const CourseLectureScreen({super.key, required this.coursenum, required this.lectureKey});

  @override
  _CourseLectureScreenState createState() => _CourseLectureScreenState();
}

class _CourseLectureScreenState extends State<CourseLectureScreen> {
  YoutubePlayerController? _youtubePlayerController;
  final Dio _dio = Dio();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final lectureWebpageUrl = '$ocwUrl/${widget.lectureKey}';
    
    try {
      final response = await _dio.get(lectureWebpageUrl);
      if (response.statusCode == 200) {
        final document = parser.parse(response.data);
        final videoPlayerDiv = document.querySelector('.video-js');
        if (videoPlayerDiv != null) {
          final dataSetup = videoPlayerDiv.attributes['data-setup'];
          if (dataSetup != null) {
            final jsonData = json.decode(dataSetup);
            final sources = jsonData['sources'] as List<dynamic>;
            if (sources.isNotEmpty) {
              final youtubeLink = sources[0]['src'] as String;
              final videoId = YoutubePlayer.convertUrlToId(youtubeLink);
              if (videoId != null) {
                setState(() {
                  _youtubePlayerController = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  );
                });
                return;
              }
            }
          }
        }
        setState(() {
          _errorMessage = 'Unable to find video for this lecture.';
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load lecture page.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching lecture page: $e';
      });
    }
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is! CourseLoadedState) {
          return const Expanded(
            child: Center(
              child: Text("Unexpected error occurred, please try again later")
            )
          );
        }

        CourseLoadedState loadedCourse = state;
        final courseRun = loadedCourse.course;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              CourseHeader(courseTitle: courseRun.course.title),
              Expanded(
                child: Center(
                  child: _youtubePlayerController != null
                      ? YoutubePlayer(
                          controller: _youtubePlayerController!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                        )
                      : _errorMessage != null
                          ? Text(_errorMessage!, style: const TextStyle(color: Colors.white))
                          : const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}