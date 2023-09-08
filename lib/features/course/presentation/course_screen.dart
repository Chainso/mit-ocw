import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, state) {
        if (state is CourseListErrorState) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is CourseListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CourseListLoadedState) {
          Course course = state.courses[widget.courseId]!;

          return Column(
            children: [
              Image.network(ocwUrl + course.imageSrc),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            course.title,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            course.runs[0].instructors.join(", "),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Column(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            "${course.coursenum} | ${course.runs[0].level?[0].name.characters.first.toUpperCase()}",
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: const TextStyle(
                              color: Color.fromRGBO(163, 31, 52, 1),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            course.departmentName.join(", "),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                subtitle: MarkdownBody(data: course.fullDescription ?? course.shortDescription),
              )
            ]
          );
        }

        return const Center(
          child: Text("Course not found"),
        );
      },
    );
  }
}

