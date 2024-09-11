import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/data/user_data_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/course_header.dart';
import 'package:mit_ocw/routes.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseListState>(
      builder: (context, state) {
        if (state is CourseListLoadedState) {
          final courseRun = state.courses[widget.courseId];
          if (courseRun != null) {
            return Scaffold(
              body: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  PinnedHeaderSliver(
                    child: CourseHeader(courseTitle: courseRun.course.title),
                  ),
                  SliverAppBar(
                    expandedHeight: 240.0,
                    collapsedHeight: 0.0,
                    toolbarHeight: 0.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
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
                                  "${courseRun.course.coursenum} | ${courseRun.course.created.year}",
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
                                const SizedBox(height: 8),
                                Text(
                                  courseRun.run.instructors.join(", "),
                                  style: TextStyle(
                                    fontSize: 14,
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
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    CourseLecturesScreenRoute(courseId: widget.courseId).go(context);
                                  },
                                  icon: const Icon(Icons.play_arrow, color: Colors.black),
                                  label: const Text('Watch Lectures', style: TextStyle(color: Colors.black)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _addToLibrary(context, courseRun),
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  label: const Text('Add to Library', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
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
                        ],
                      ),
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

  void _addToLibrary(BuildContext context, FullCourseRun courseRun) {
    context.read<UserDataRepository>().addToLibrary(courseRun.course.id).then((added) {
      if (mounted) {
        final addedSnackbar = SnackBar(
          content: Text('Added ${courseRun.course.title} to my library'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              context.read<UserDataRepository>().removeFromLibrary(courseRun.course.id).then((_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                }
              });
            },
          ),
        );

        final alreadyExistsSnackbar = SnackBar(
          content: Text('${courseRun.course.title} is already in my library'),
          duration: const Duration(seconds: 5),
        );

        ScaffoldMessenger.of(context).showSnackBar(added ? addedSnackbar : alreadyExistsSnackbar);
      }
    });
  }
}