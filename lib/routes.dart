// GoRouter configuration

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/features/course/presentation/course_detail_screen.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_list.dart';
import 'package:mit_ocw/features/course/presentation/home/home.dart';
import 'package:mit_ocw/features/course/presentation/video_player_screen.dart';
import 'package:mit_ocw/features/course/presentation/search_screen.dart';

part "routes.g.dart";

@TypedStatefulShellRoute<RootRoute>(
  branches: [
    TypedStatefulShellBranch<HomeScreenBranch>(
      routes: [
        TypedGoRoute<HomeScreenRoute>(
          path: "/home",
        ),
        TypedGoRoute<SearchScreenRoute>(
          path: "/search",
        )
      ]
    ),
    TypedStatefulShellBranch<CourseScreenBranch>(
      routes: [
        TypedStatefulShellRoute<CourseScreenRoute>(
          branches: [
            TypedStatefulShellBranch<StatefulShellBranchData>(
              routes: [
                TypedGoRoute<HomeRedirectRoute>(
                  path: "/",
                ),
                TypedGoRoute<CourseScreenHomeRedirectRoute>(
                  path: "/courses/:courseId",
                  routes: [
                    TypedGoRoute<CourseHomeScreenRoute>(
                      path: "home",
                    ),
                    TypedGoRoute<CourseLecturesScreenRoute>(
                      path: "lectures",
                      routes: [
                        TypedGoRoute<VideoPlayerScreenRoute>(
                          path: ":lectureKey",
                        ),
                      ]
                    )
                  ]
                )
              ]
            )
          ]
        )
      ],
    ),
  ]
)

@immutable
class RootRoute extends StatefulShellRouteData {
  const RootRoute();
  
  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "My Library"),
        ],
      ),
    );
  }
}

@immutable
class HomeScreenBranch extends StatefulShellBranchData {
  const HomeScreenBranch();
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
class HomeRedirectRoute extends GoRouteData {
  const HomeRedirectRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return const HomeScreenRoute().location;
  }
}

@immutable
class CourseScreenBranch extends StatefulShellBranchData {
  const CourseScreenBranch();
}

@immutable
class CourseScreenRoute extends StatefulShellRouteData {
  const CourseScreenRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return Scaffold(
      body: navigationShell,
      drawer: NavigationDrawer(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        children: const [
          ListTile(
            title: Text("Course Home")
          ),
          ListTile(
            title: Text("Lectures")
          ),
        ],
      ),
    );
  }
}

@immutable
class CourseScreenHomeRedirectRoute extends GoRouteData {
  final int courseId;

  const CourseScreenHomeRedirectRoute({required this.courseId});

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return CourseHomeScreenRoute(courseId: courseId).location;
  }
}

@immutable
class CourseHomeScreenRoute extends GoRouteData {
  const CourseHomeScreenRoute({required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDetailScreen(courseId: courseId);
  }
}

@immutable
class CourseLecturesScreenRoute extends GoRouteData {
  const CourseLecturesScreenRoute({required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseLecturesScreen(courseId: courseId);
  }
}

@immutable
class VideoPlayerScreenRoute extends GoRouteData {
  const VideoPlayerScreenRoute({
    required this.courseId,
    required this.lectureKey,
  });

  final int courseId;
  final String lectureKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VideoPlayerScreen(lectureKey: lectureKey);
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

