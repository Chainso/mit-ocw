import 'package:flutter/material.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/course_tile.dart';

class CategorySection extends StatelessWidget {
  final String category;
  final List<FullCourseRun> courses;

  const CategorySection({Key? key, required this.category, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final itemHeight = isWide ? 300.0 : 250.0;
        final itemWidth = isWide ? 250.0 : 200.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, isWide ? 32 : 24, 16, 12),
              child: Text(
                category,
                style: TextStyle(
                  color: Colors.white, // White text for category names
                  fontSize: isWide ? 28 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: itemHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: itemWidth,
                      child: CourseTile(courseRun: courses[index]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: isWide ? 32 : 24),
          ],
        );
      },
    );
  }
}