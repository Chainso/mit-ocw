import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/course/presentation/course_header.dart';
import 'package:mit_ocw/routes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
                      backgroundColor: Colors.black,
                      body: Column(
                        children: [
                          CourseHeader(courseTitle: courseRun.course.title),
                          Expanded(
                            child: _buildLectureList(state.lectures),
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

  Widget _buildLectureList(List<Lecture> lectures) {
    return ScrollablePositionedList.builder(
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final lecture = lectures[index];
        return InkWell(
          onTap: () {
            CourseLectureScreenRoute(
              courseId: courseId,
              lectureKey: lecture.key,
            ).go(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    lecture.imageSrc ?? 'https://via.placeholder.com/120x68',
                    width: 120,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    lecture.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
