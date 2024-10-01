import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/routes.dart';

class CourseLectureList extends StatelessWidget {
  final FullCourseRun courseRun;
  final List<Lecture> lectures;

  const CourseLectureList({
    super.key,
    required this.courseRun,
    required this.lectures,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<WatchHistoryRepository>().getWatchHistoryForCourse(courseRun.course.coursenum),
      builder: (context, snapshot) {
        return _buildLectures(context, snapshot);
      }
    );
  }

  SliverList _buildLectures(
    BuildContext context,
    AsyncSnapshot<Map<String, LectureWatchHistoryData>> snapshot
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildLecture(context, snapshot, index);
        },
        childCount: lectures.length,
      ),
    );

  }

  Widget _buildLecture(
    BuildContext context,
    AsyncSnapshot<Map<String, LectureWatchHistoryData>> snapshot,
    int index
  ) {
    final lecture = lectures[index];

    Widget lectureImage = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        lecture.imageSrc ?? 'https://via.placeholder.com/120x68',
        width: 120,
        height: 68,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[800],
            child: const Icon(Icons.error, color: Colors.white),
          );
        },
      ),
    );

    if (snapshot.hasData) {
      // Show red bar as a % of watched
      final fullWatchHistory = snapshot.data!;
      final watchHistory = fullWatchHistory[lecture.key];

      if (watchHistory != null) {
        final watchedPercent = watchHistory.position / watchHistory.lectureLength;

        if (watchedPercent > 0) {
          // Gray bar for full length, red bar for watched %
          final watchedBar = Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: watchedPercent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          );

          lectureImage = Stack(
            children: [
            lectureImage,
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: watchedBar,
              ),
            ],
          );
        }
      }
    }

    return InkWell(
      onTap: () {
        CourseLectureScreenRoute(
          coursenum: courseRun.course.coursenum,
          lectureKey: lecture.key,
          lectureNumber: index + 1
        ).go(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            lectureImage,
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
  }
}
