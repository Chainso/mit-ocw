import 'package:flutter/material.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/routes.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.courseRun});

  final FullCourseRun courseRun;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 200;
        return GestureDetector(
          onTap: () {
            CourseHomeScreenRoute(courseId: courseRun.course.id).go(context);
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    ocwUrl + courseRun.course.imageSrc,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: isWide ? constraints.maxHeight * 0.6 : constraints.maxHeight * 0.5,
                  ),
                ),
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
