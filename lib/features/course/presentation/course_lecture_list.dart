import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_tile.dart';
import 'package:mit_ocw/features/course/presentation/video_player_screen.dart';

class CourseLecturesScreen extends StatelessWidget {
  final int courseId;

  const CourseLecturesScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, courseState) {
        if (courseState is CourseListLoadedState) {
          final courseRun = courseState.courses[courseId];
          if (courseRun != null) {
            return BlocProvider(
              create: (context) => LectureBloc(
                context.read<CourseRepository>(),
              )..add(LectureListLoadEvent(courseRun.course.coursenum)),
              child: BlocBuilder<LectureBloc, LectureListState>(
                builder: (context, state) {
                  if (state is LectureListLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LectureListErrorState) {
                    return Center(child: Text(state.error, style: const TextStyle(color: Colors.white)));
                  } else if (state is LectureListLoadedState) {
                    return Scaffold(
                      body: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 200.0,
                            pinned: true,
                            flexibleSpace: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.network(
                                    "$ocwUrl${courseRun.course.imageSrc}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                  child: Text(
                                    courseRun.course.title,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(16.0),
                            sliver: SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 16 / 9,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return LectureTile(
                                    lecture: state.lectures[index],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VideoPlayerScreen(lectureKey: state.lectures[index].key),
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: state.lectures.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text('Unexpected state'));
                },
              ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
