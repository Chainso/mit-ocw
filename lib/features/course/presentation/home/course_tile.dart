import 'package:flutter/material.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/routes.dart';

class CourseTile extends StatelessWidget {
  final CourseRunWithLatestLectureWatchHistory courseRunWithHistory;
  final Function(BuildContext, FullCourseRun)? onLongPress;

  const CourseTile({
    super.key,
    required this.courseRunWithHistory,
    this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    final courseRun = courseRunWithHistory.courseRun;
    final latestLectureWatchHistory = courseRunWithHistory.latestLectureWatchHistory;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 200;

        Widget imageBox = ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(
            ocwUrl + courseRun.course.imageSrc,
            fit: BoxFit.cover,
            width: double.infinity,
            height: isWide ? constraints.maxHeight * 0.6 : constraints.maxHeight * 0.5,
          ),
        );

        if (latestLectureWatchHistory != null) {
          // Show red bar as a % of watched
          final watchedPercent = latestLectureWatchHistory.position / latestLectureWatchHistory.lectureLength;

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

          imageBox = Stack(
            children: [
              imageBox,
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: watchedBar,
              ),
            ],
          );
        }

        return InkWell(
          onTap: () {
            CourseHomeScreenRoute(coursenum: courseRun.course.coursenum).go(context);
          },
          onLongPress: onLongPress != null ? () => onLongPress!(context, courseRun) : null,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageBox,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseRun.course.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isWide ? 16 : 11,
                          ),
                        )
                      ],
                    ),
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

class CourseRunWithLatestLectureWatchHistory {
  final FullCourseRun courseRun;
  final LectureWatchHistoryData? latestLectureWatchHistory;

  const CourseRunWithLatestLectureWatchHistory({
    required this.courseRun,
    this.latestLectureWatchHistory,
  });
}
