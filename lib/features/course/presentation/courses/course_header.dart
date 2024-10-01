import 'package:flutter/material.dart';

class CourseHeader extends StatelessWidget {
  final String courseTitle;

  const CourseHeader({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            courseTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(color: Colors.white24, thickness: 1, height: 1),
      ],
    );
  }
}
