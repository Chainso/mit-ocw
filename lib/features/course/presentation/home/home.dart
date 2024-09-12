import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/features/course/presentation/home/category_section.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/home/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: BlocBuilder<CourseBloc, CourseListState>(
              builder: (context, state) {
                return switch (state) {
                  CourseListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  CourseListErrorState(error: final error) => Center(
                      child: Text(error, style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  CourseListLoadedState(courses: final courses) => _buildDepartmentList(courses),
                  _ => const Center(
                      child: Text('Unexpected state', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentList(Map<int, FullCourseRun> courses) {
    final departmentCourses = _categorizeCoursesByDepartment(courses.values.toList());
    
    return ListView.builder(
      itemCount: departmentCourses.length,
      itemBuilder: (context, index) {
        final entry = departmentCourses.entries.elementAt(index);
        return CategorySection(
          category: entry.key,
          courses: entry.value,
        );
      },
    );
  }

  Map<String, List<FullCourseRun>> _categorizeCoursesByDepartment(List<FullCourseRun> courses) {
    final Map<String, List<FullCourseRun>> categorized = {};
    
    for (var courseRun in courses) {
      List<String> departments = courseRun.course.departmentName;

      if (departments.isEmpty) {
        departments = ['Uncategorized'];
      }

      for (var department in courseRun.course.departmentName) {
        if (!categorized.containsKey(department)) {
          categorized[department] = [];
        }
        categorized[department]!.add(courseRun);
      }
    }

    // Sort departments alphabetically
    final sortedDepartments = categorized.keys.toList()..sort();
    
    return Map.fromEntries(
      sortedDepartments.map((dept) => MapEntry(dept, categorized[dept]!))
    );
  }
}