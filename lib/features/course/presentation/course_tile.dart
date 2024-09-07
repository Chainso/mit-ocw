import 'package:flutter/material.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:go_router/go_router.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.courseRun});

  final FullCourseRun courseRun;

  @override
  Widget build(BuildContext context) {
    const placeholder = 'https://placehold.co/600x400?text=No+Image';
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 200;
        return GestureDetector(
          onTap: () {
            context.go('/course/${courseRun.course.id}/home');
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
                    courseRun.course.imageSrc != null && courseRun.course.imageSrc!.isNotEmpty
                        ? ocwUrl + courseRun.course.imageSrc!
                        : placeholder,
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isWide ? 16 : 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          courseRun.course.coursenum,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isWide ? 14 : 12,
                          ),
                        ),
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
