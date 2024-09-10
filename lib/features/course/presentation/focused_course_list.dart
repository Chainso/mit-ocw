import 'package:flutter/material.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/course_tile.dart';

class FocusedCourseList extends StatelessWidget {
  final List<FullCourseRun> courses;

  const FocusedCourseList({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.05,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) => CourseTile(courseRun: courses[index]),
    );
  }
}