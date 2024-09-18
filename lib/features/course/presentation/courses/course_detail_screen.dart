import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/library_bloc/library_bloc.dart';
import 'package:mit_ocw/config/ocw_config.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_header.dart';
import 'package:mit_ocw/routes.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, required this.coursenum});

  final String coursenum;

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
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, courseState) {
        print("Course state in details is $courseState");
        if (courseState is! CourseLoadedState) {
          return const Expanded(
            child: Center(
              child: Text("Unexpected error occurred, please try again later")
            )
          );
        }

        CourseLoadedState loadedCourse = courseState;
        final courseRun = loadedCourse.course;

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
                                CourseLecturesScreenRoute(coursenum: widget.coursenum).go(context);
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
                            child: BlocConsumer<LibraryBloc, LibraryState>(
                              listener: (context, libraryState) {
                                switch (libraryState) {
                                  case LibraryCourseAddedState courseAddedState:
                                    if (courseAddedState.isUndo) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Added ${courseAddedState.coursenum} to library'),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            context.read<LibraryBloc>().add(LibraryRemoveCourseEvent(coursenum: courseRun.course.coursenum));
                                          },
                                        ),
                                      ),
                                    );
                                  case LibraryCourseRemovedState courseRemovedState:
                                    if (courseRemovedState.isUndo) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Removed ${courseRemovedState.coursenum} from library'),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            context.read<LibraryBloc>().add(LibraryAddCourseEvent(coursenum: courseRun.course.coursenum));
                                          },
                                        ),
                                      ),
                                    );
                                  case LibraryAddCourseErrorState addCourseError:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Error adding ${addCourseError.coursenum} to library, try again later'),
                                          duration: const Duration(seconds: 5),
                                          action: SnackBarAction(
                                            label: 'Retry',
                                            onPressed: () => context.read<LibraryBloc>().add(LibraryAddCourseEvent(coursenum: addCourseError.coursenum)),
                                            ),
                                          ),
                                        );
                                    break;
                                  case LibraryRemoveCourseErrorState removeCourseError:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Error removing ${removeCourseError.coursenum} from library, try again later'),
                                          duration: const Duration(seconds: 5),
                                          action: SnackBarAction(
                                            label: 'Retry',
                                            onPressed: () => context.read<LibraryBloc>().add(LibraryRemoveCourseEvent(coursenum: removeCourseError.coursenum)),
                                            ),
                                          ),
                                        );
                                    break;
                                  default:
                                }
                              },
                              builder: (context, libraryState) {
                                final isCourseInLibrary = libraryState.library.coursenums.any((coursenum) => coursenum == courseRun.course.coursenum);

                                if (isCourseInLibrary) {
                                  return ElevatedButton.icon(
                                    onPressed: () => context.read<LibraryBloc>().add(LibraryRemoveCourseEvent(coursenum: courseRun.course.coursenum)),
                                    icon: const Icon(Icons.remove, color: Colors.white),
                                    label: const Text('Remove from Library', style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                    ),
                                  );
                                } else {
                                  return ElevatedButton.icon(
                                    onPressed: () => context.read<LibraryBloc>().add(LibraryAddCourseEvent(coursenum: courseRun.course.coursenum)),
                                    icon: const Icon(Icons.add, color: Colors.white),
                                    label: const Text('Add to Library', style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[800],
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                    ),
                                  );
                                }
                              }
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
