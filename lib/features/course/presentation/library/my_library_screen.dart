import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/bloc/library_bloc/library_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/presentation/home/focused_course_list.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({super.key});

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  @override
  void initState() {
    print("Initializing MyLibraryScreen");
    super.initState();
  }

  void _showContextMenu(BuildContext context, FullCourseRun courseRun) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: const Text('Remove'),
          onTap: () => context.read<LibraryBloc>().add(LibraryRemoveCourseEvent(coursenum: courseRun.course.coursenum)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: RefreshIndicator(
            onRefresh: () async => context.read<LibraryBloc>().add(const LibraryLoadEvent()),
            child: BlocConsumer<LibraryBloc, LibraryState>(
              listener: (context, libraryState) {
                switch (libraryState) {
                  case LibraryCourseRemovedState courseRemovedState:
                    if (courseRemovedState.isUndo) {
                      return;
                    }

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed ${courseRemovedState.coursenum} from library'),
                        duration: const Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () => context.read<LibraryBloc>().add(LibraryAddCourseEvent(coursenum: courseRemovedState.coursenum, isUndo: true)),
                        ),
                      ),
                    );
                    break;
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
                switch (libraryState) {
                  case LibraryWaitingState _:
                    return const Center(child: CircularProgressIndicator());
                  case LibraryLoadErrorState _:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Error loading library, try again later'),
                          ElevatedButton(
                            onPressed: () => context.read<LibraryBloc>().add(const LibraryLoadEvent()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  case LibraryErrorState _:
                  case LibraryLoadedState _:
                    final libraryCourseNums = libraryState.library.coursenums;

                    if (libraryCourseNums.isEmpty) {
                      return const Center(child: Text('Your library is empty.'));
                    } else {
                      return FutureBuilder<Map<String, FullCourseRun>>(
                        future: context.read<CourseRepository>().getCoursesMap(libraryCourseNums),
                        builder: (context, courseMapSnapshot) {
                          if (courseMapSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (courseMapSnapshot.hasError) {
                            return Center(child: Text('Error: ${courseMapSnapshot.error}'));
                          } else if (!courseMapSnapshot.hasData || courseMapSnapshot.data!.isEmpty) {
                            return const Center(child: Text('Your library is empty.'));
                          } else {
                            final loadedCourses = courseMapSnapshot.data!;

                            final libraryCourses = libraryCourseNums.map((coursenum) => loadedCourses[coursenum])
                              .where((course) => course != null)
                              .toList();

                            return FocusedCourseList(
                              courses: libraryCourses.cast<FullCourseRun>(),
                              onLongPress: _showContextMenu,
                            );
                          }
                        },
                      );
                    }
                }
              }
            ),
          ),
        ),
      ],
    );
  }
}
