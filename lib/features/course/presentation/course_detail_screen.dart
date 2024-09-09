import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_list.dart';
import 'package:mit_ocw/routes.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key, required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, state) {
        if (state is CourseListLoadedState) {
          final courseRun = state.courses[courseId];
          if (courseRun != null) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                ocwUrl + courseRun.course.imageSrc,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                    stops: const [0.5, 1.0],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                right: 16,
                                bottom: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      courseRun.course.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${courseRun.course.coursenum} | ${courseRun.run.instructors.join(", ")}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.8),
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MarkdownBody(
                                data: courseRun.course.fullDescription ?? courseRun.course.shortDescription,
                                styleSheet: MarkdownStyleSheet(
                                  p: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: courseRun.course.courseFeatureTags
                                    .map((feature) => _buildFeatureChip(feature))
                                    .toList(),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  CourseLecturesScreenRoute(courseId: courseId).go(context);
                                },
                                child: const Text('Start Learning'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade900,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildFeatureChip(String feature) {
    return Chip(
      label: Text(
        feature,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade700,
      elevation: 2,
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}