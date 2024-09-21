import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/home/course_tile.dart';
import 'package:mit_ocw/features/persistence/database.dart';

class FocusedCourseList extends StatelessWidget {
  final List<FullCourseRun> courses;
  final Function(BuildContext, FullCourseRun)? onLongPress;

  const FocusedCourseList({
    super.key,
    required this.courses,
    this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    final coursenums = courses.map((courseRun) => courseRun.course.coursenum).toList();

    return FutureBuilder(
      future: context.read<WatchHistoryRepository>().getLatestWatchedLectureForCourses(coursenums),
      builder: (context, snapshot) {
        Map<String, LectureWatchHistoryData> watchHistories = {};

        if (snapshot.hasData) {
          watchHistories = snapshot.data!;
        }

        final courseRunsWithWatchHistory = courses.map((courseRun) {
          final latestLectureWatchHistory = watchHistories[courseRun.course.coursenum];

          return CourseRunWithLatestLectureWatchHistory(
            courseRun: courseRun,
            latestLectureWatchHistory: latestLectureWatchHistory,
          );
        }).toList();

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.05,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: courseRunsWithWatchHistory.length,
          itemBuilder: (context, index) => CourseTile(
            courseRunWithHistory: courseRunsWithWatchHistory[index],
            onLongPress: onLongPress
          ),
        );
      }
    );
  }
}
