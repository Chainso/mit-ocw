import 'package:flutter/material.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/course_tile.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key, required this.courses});

  final List<Course> courses;

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ListView(
      padding: const EdgeInsets.all(10),
      children: widget.courses.map((course) => CourseTile(course: course)).toList(),
    );
  }
}
