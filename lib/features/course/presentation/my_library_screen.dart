import 'package:flutter/material.dart';
import 'package:mit_ocw/features/course/presentation/focused_course_list.dart';

class MyLibraryScreen extends StatelessWidget {
  const MyLibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'My Library',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.white24, thickness: 1, height: 1),
              ],
            ),
          ),
          Expanded(
            child: FocusedCourseList(courses: []),
          ),
        ],
      ),
    );
  }
}