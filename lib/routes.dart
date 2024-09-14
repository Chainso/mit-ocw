// GoRouter configuration

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_detail_screen.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_header.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_lecture_list.dart';
import 'package:mit_ocw/features/course/presentation/home/home.dart';
import 'package:mit_ocw/features/course/presentation/home/search_screen.dart';
import 'package:mit_ocw/features/course/presentation/library/my_library_screen.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_lecture_screen.dart';

part "routes.g.dart";

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch<MainContentBranch>(
      routes: [
        TypedGoRoute<HomeRedirectRoute>(
          path: "/",
        ),
        TypedGoRoute<HomeScreenRoute>(
          name: "home",
          path: "/home",
        ),
        TypedGoRoute<SearchScreenRoute>(
          name: "search",
          path: "/search",
        ),
        TypedGoRoute<CourseHomeScreenRedirectRoute>(
          name: "course-home-redirect",
          path: "/courses/:coursenum",
          routes: [
            TypedStatefulShellRoute<CourseScreenRoute>(
              branches: [
                TypedStatefulShellBranch<CourseHomeBranch>(
                  routes: [
                    TypedGoRoute<CourseHomeScreenRoute>(
                      path: "home",
                    ),
                  ]
                ),
                TypedStatefulShellBranch<CourseLecturesBranch>(
                  routes: [
                    TypedGoRoute<CourseLecturesScreenRoute>(
                      path: "lectures",
                      routes: [
                        TypedGoRoute<CourseLectureScreenRoute>(
                          path: ":lectureKey",
                        ),
                      ]
                    )
                  ]
                ),
              ]
            )
          ],
        ),
      ]
    ),
    TypedStatefulShellBranch<MyLibraryScreenBranch>(
      routes: [
        TypedGoRoute<MyLibraryScreenRoute>(
          name: "my-library",
          path: "/my-library",
        ),
      ]
    ),
  ]
)

@immutable
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();
  
  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => {
          navigationShell.goBranch(
            index,
            initialLocation: index == 0,
          ),
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "My Library"),
        ],
      ),
    );
  }
}

@immutable
class MainContentBranch extends StatefulShellBranchData {
  const MainContentBranch();
}

@immutable
class HomeRedirectRoute extends GoRouteData {
  const HomeRedirectRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return const HomeScreenRoute().location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@immutable
class HomeScreenRoute extends GoRouteData {
  const HomeScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@immutable
class SearchScreenRoute extends GoRouteData {
  final String? q;

  const SearchScreenRoute({this.q});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SearchScreen(initialQuery: q);
  }
}

@immutable
class CourseHomeScreenRedirectRoute extends GoRouteData {
  final String coursenum;
  const CourseHomeScreenRedirectRoute({required this.coursenum});

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (state.pageKey.value == location) {
      return CourseHomeScreenRoute(coursenum: coursenum).location;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDetailScreen(coursenum: coursenum);
  }
}

@immutable
class CourseScreenRoute extends StatefulShellRouteData {
  const CourseScreenRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: BlocProvider<CourseBloc>(
        create: (context) => CourseBloc(
          context.read<CourseRepository>(),
        )..add(CourseLoadEvent(coursenum: state.pathParameters["coursenum"]!)),
        child: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, courseState) {
            switch (courseState) {
              case CourseWaitingState _:
              case CourseLoadingState _:
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                );
              case CourseLoadedState _:
                return Stack(
                  children: [
                    CourseHeader(courseTitle: courseState.course.course.title),
                    navigationShell,
                  ]
                );
              case CourseNotFoundState notFound:
                return Expanded(
                  child: Center(
                    child: Text("Course ${notFound.coursenum} not found")
                  )
                );
              case CourseErrorState error:
                return Expanded(
                  child: Center(
                    child: Text("Could not load course ${error.coursenum}: ${error.error.toString()}")
                  )
                );
            }
          }
        )
      ),
      drawer: NavigationDrawer(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          // Close drawer
          Navigator.pop(context);

          // Navigate to the selected branch
          navigationShell.goBranch(
            index,
            initialLocation: index == 0,
          );
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text("Course Home"),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.video_library),
            label: Text("Lectures"),
          ),
        ],
      )
    );
  }
}

@immutable
class CourseHomeBranch extends StatefulShellBranchData {
  const CourseHomeBranch();
}

@immutable
class CourseHomeScreenRoute extends GoRouteData {
  final String coursenum;

  const CourseHomeScreenRoute({required this.coursenum});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    print("Building CourseHomeScreenRoute for coursenum: $coursenum");
    return CourseDetailScreen(coursenum: coursenum);
  }
}

@immutable
class CourseLecturesBranch extends StatefulShellBranchData {
  const CourseLecturesBranch();
}

@immutable
class CourseLecturesScreenRoute extends GoRouteData {
  const CourseLecturesScreenRoute({required this.coursenum});

  final String coursenum;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    print("Building CourseLecturesScreenRoute for coursenum: $coursenum");
    return CourseLecturesScreen(coursenum: coursenum);
  }
}

@immutable
class CourseLectureScreenRoute extends GoRouteData {
  const CourseLectureScreenRoute({
    required this.coursenum,
    required this.lectureKey
  });

  final String coursenum;
  final String lectureKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseLectureScreen(
      coursenum: coursenum,
      lectureKey: lectureKey
    );
  }
}

@immutable
class MyLibraryScreenBranch extends StatefulShellBranchData {
  const MyLibraryScreenBranch();
}

@immutable
class MyLibraryScreenRoute extends GoRouteData {
  const MyLibraryScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MyLibraryScreen(key: UniqueKey());
  }
}