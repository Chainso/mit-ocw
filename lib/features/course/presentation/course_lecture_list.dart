import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_tile.dart';
import 'package:mit_ocw/features/course/presentation/video_player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:mit_ocw/routes.dart';

class CourseLecturesScreen extends StatelessWidget {
  const CourseLecturesScreen({super.key, required this.courseId});

  final int courseId;

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
          CourseListLoadedState(courses: var courses) => () {
            FullCourseRun courseRun = courses[courseId]!;

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
                    LectureListLoadedState(lectures: var lectures) => ListView.builder(
                      itemCount: lectures.length,
                      itemBuilder: (context, index) => LectureTile(
                        courseRun: courseRun,
                        lecture: lectures[index],
                        onTap: () {
                          VideoPlayerScreenRoute(
                            courseId: courseId,
                            lectureKey: lectures[index].key,
                          ).go(context);
                        },
                      ),
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
}
