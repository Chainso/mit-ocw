import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/data/user_data_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';
import 'package:mit_ocw/features/course/domain/library.dart';
import 'package:mit_ocw/features/course/presentation/home/focused_course_list.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({super.key});

  @override
  State<MyLibraryScreen> createState() => _MyLibraryScreenState();
}

class _MyLibraryScreenState extends State<MyLibraryScreen> {
  late Future<Library> _libraryFuture;

  @override
  void initState() {
    print("Initializing MyLibraryScreen");
    super.initState();
    _refreshLibrary();
  }

  void _refreshLibrary() {
    print("Refreshing library");
    
    setState(() {
      _libraryFuture = context.read<UserDataRepository>().getLibrary();
    });

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
          onTap: () => _removeFromLibrary(courseRun),
        ),
      ],
    );
  }

  void _removeFromLibrary(FullCourseRun courseRun) {
    context.read<UserDataRepository>().removeFromLibrary(courseRun.course.coursenum).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed ${courseRun.course.title} from my library'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                context.read<UserDataRepository>().addToLibrary(courseRun.course.coursenum).then((_) {
                  if (mounted) {
                    _refreshLibrary();
                    ScaffoldMessenger.of(context).clearSnackBars();
                  }
                });
              },
            ),
          ),
        );
        _refreshLibrary();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
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
              onRefresh: () async {
                _refreshLibrary();
              },
              child: FutureBuilder<Library>(
                future: _libraryFuture,
                builder: (context, librarySnapshot) {
                  if (librarySnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (librarySnapshot.hasError) {
                    return Center(child: Text('Error: ${librarySnapshot.error}'));
                  } else if (!librarySnapshot.hasData || librarySnapshot.data!.courses.isEmpty) {
                    return const Center(child: Text('Your library is empty.'));
                  } else {
                    final libraryCourseNums = librarySnapshot.data?.courses ?? [];

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
              ),
            ),
          ),
        ],
      ),
    );
  }
}