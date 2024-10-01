import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mit_ocw/bloc/library_bloc/library_bloc.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/routes.dart';

class CourseOverviewScreen extends StatelessWidget {
  final FullCourseRun courseRun;
  final List<Lecture> lectures;

  const CourseOverviewScreen({super.key, required this.courseRun, required this.lectures});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Row(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: context
                      .read<WatchHistoryRepository>()
                      .getLatestWatchedLectureForCourses([courseRun.course.coursenum]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
      
                    LectureWatchHistoryData? latestWatchedFromSnapshot =
                        snapshot.data?[courseRun.course.coursenum];
      
                    if (latestWatchedFromSnapshot == null) {
                      // Start from lecture 1
                      return ElevatedButton.icon(
                        onPressed: () {
                          CourseLectureScreenRoute(
                                  coursenum: courseRun.course.coursenum,
                                  lectureKey: lectures.first.key,
                                  lectureNumber: 1)
                              .go(context);
                        },
                        icon: const Icon(Icons.play_arrow, color: Colors.black),
                        label: const Text('Watch Lectures',
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      );
                    } else {
                      // Continue from latest watched
                      return ElevatedButton.icon(
                        onPressed: () {
                          CourseLectureScreenRoute(
                            coursenum: courseRun.course.coursenum,
                            lectureKey: latestWatchedFromSnapshot.lectureKey,
                            lectureNumber: latestWatchedFromSnapshot.lectureNumber
                          ).go(context);
                        },
                        icon: const Icon(Icons.play_arrow, color: Colors.black),
                        label: const Text('Continue Watching',
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      );
                    }
                  }
                )
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
                            content:
                                Text('Added ${courseAddedState.coursenum} to library'),
                            duration: const Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                context.read<LibraryBloc>().add(
                                    LibraryRemoveCourseEvent(
                                        coursenum: courseRun.course.coursenum,
                                        isUndo: true));
                              },
                            ),
                          ),
                        );
                        break;
                      case LibraryCourseRemovedState courseRemovedState:
                        if (courseRemovedState.isUndo) {
                          return;
                        }
      
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Removed ${courseRemovedState.coursenum} from library'),
                            duration: const Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                context.read<LibraryBloc>().add(LibraryAddCourseEvent(
                                    coursenum: courseRun.course.coursenum,
                                    isUndo: true));
                              },
                            ),
                          ),
                        );
                        break;
                      case LibraryAddCourseErrorState addCourseError:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Error adding ${addCourseError.coursenum} to library, try again later'),
                            duration: const Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Retry',
                              onPressed: () => context.read<LibraryBloc>().add(
                                  LibraryAddCourseEvent(
                                      coursenum: addCourseError.coursenum)),
                            ),
                          ),
                        );
                        break;
                      case LibraryRemoveCourseErrorState removeCourseError:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Error removing ${removeCourseError.coursenum} from library, try again later'),
                            duration: const Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Retry',
                              onPressed: () => context.read<LibraryBloc>().add(
                                  LibraryRemoveCourseEvent(
                                      coursenum: removeCourseError.coursenum)),
                            ),
                          ),
                        );
                        break;
                      default:
                    }
                  },
                  builder: (context, libraryState) {
                    final isCourseInLibrary = libraryState.library.coursenums
                        .any((coursenum) => coursenum == courseRun.course.coursenum);
      
                    if (isCourseInLibrary) {
                      return ElevatedButton.icon(
                        onPressed: () => context.read<LibraryBloc>().add(
                            LibraryRemoveCourseEvent(
                                coursenum: courseRun.course.coursenum)),
                        icon: const Icon(Icons.remove, color: Colors.white),
                        label: const Text('Remove from Library',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      );
                    } else {
                      return ElevatedButton.icon(
                        onPressed: () => context.read<LibraryBloc>().add(
                            LibraryAddCourseEvent(
                                coursenum: courseRun.course.coursenum)),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('Add to Library',
                            style: TextStyle(color: Colors.white)),
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
        ]),
      ),
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
