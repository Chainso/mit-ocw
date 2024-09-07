import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/features/course/presentation/course_detail_screen.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_list.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, state) {
        if (state is CourseListLoadedState) {
          final courseRun = state.courses[widget.courseId];
          if (courseRun != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(courseRun.course.title),
                backgroundColor: Colors.red.shade900,
              ),
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.video_library),
                        label: Text('Lectures'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: _selectedIndex == 0
                        ? CourseDetailScreen(courseId: widget.courseId)
                        : CourseLecturesScreen(courseId: widget.courseId),
                  ),
                ],
              ),
            );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
