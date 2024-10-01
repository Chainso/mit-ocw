// GoRouter configuration

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_screen.dart';
import 'package:mit_ocw/features/course/presentation/home/home.dart';
import 'package:mit_ocw/features/course/presentation/home/search_screen.dart';
import 'package:mit_ocw/features/course/presentation/library/my_library_screen.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_lecture_screen.dart';

part "routes.g.dart";

final rootNavigatorKey = GlobalKey<NavigatorState>();

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
          name: "course",
          path: "/courses/:coursenum",
          routes: [
            TypedStatefulShellRoute<CourseRootShellRoute>(
              branches: [
                TypedStatefulShellBranch<CourseBranch>(
                  routes: [
                    TypedGoRoute<CourseRoute>(
                      name: "course-details",
                      path: "details",
                      routes: [
                        TypedGoRoute<CourseLectureScreenRoute>(
                          path: ":lectureKey/:lectureNumber",
                        )
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
    if (state.uri.toString() == location) {
      return CourseRoute(coursenum: coursenum).location;
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if (state.uri.toString() == location) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(const HomeScreenRoute().location);
      });
    }

    return const Expanded(
      child: Center(
        child: CircularProgressIndicator()
      )
    );
  }
}

@immutable
class CourseRootShellRoute extends StatefulShellRouteData {
  const CourseRootShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    final coursenum = state.pathParameters["coursenum"]!;

    return BlocProvider<CourseBloc>(
      create: (context) => CourseBloc(
        context.read<CourseRepository>(),
      )..add(CourseLoadEvent(coursenum: coursenum)),
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
              return BlocProvider(
                create: (context) => LectureBloc(
                  context.read<CourseRepository>(),
                )..add(LectureListLoadEvent(coursenum: coursenum)),
                child: navigationShell,
              );
            case CourseNotFoundState notFound:
              return Expanded(
                child: Center(
                  child: Text("Course ${notFound.coursenum} could not be found")
                )
              );
            case CourseErrorState error:
              return Expanded(
                child: Center(
                  child: Text("Could not load course ${error.coursenum}, please try again")
                )
              );
          }
        }
      )
    );
  }
}

@immutable
class CourseBranch extends StatefulShellBranchData {
  const CourseBranch();
}

@immutable
class CourseRoute extends GoRouteData {
  final String coursenum;

  const CourseRoute({required this.coursenum});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseScreen(coursenum: coursenum);
  }
}

@immutable
class CourseLectureScreenRoute extends GoRouteData {
  const CourseLectureScreenRoute({
    required this.coursenum,
    required this.lectureKey,
    required this.lectureNumber
  });

  final String coursenum;
  final String lectureKey;
  final int lectureNumber;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseLectureScreen(
      coursenum: coursenum,
      lectureKey: lectureKey,
      lectureNumber: lectureNumber,
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
