import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/features/course/presentation/category_section.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red.shade900,
      ),
      backgroundColor: const Color(0xFF121212), // Very dark gray background
      body: BlocBuilder<CourseBloc, CourseListState>(
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
      // Use the first department name if available, otherwise use a default category
      String department = courseRun.course.departmentName.isNotEmpty 
          ? courseRun.course.departmentName.first 
          : 'Uncategorized';
      
      if (!categorized.containsKey(department)) {
        categorized[department] = [];
      }
      categorized[department]!.add(courseRun);
    }

    // Sort departments alphabetically
    final sortedDepartments = categorized.keys.toList()..sort();
    
    return Map.fromEntries(
      sortedDepartments.map((dept) => MapEntry(dept, categorized[dept]!))
    );
  }
}