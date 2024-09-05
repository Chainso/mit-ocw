// GoRouter configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/features/course/presentation/course_home.dart';
import 'package:mit_ocw/features/course/presentation/course_lecture_list.dart';
import 'package:mit_ocw/home.dart';
import 'package:mit_ocw/features/course/presentation/video_player_screen.dart';

part "routes.g.dart";

final _sectionNavigatorKey = GlobalKey<NavigatorState>();

StatefulShellRoute rootRoute() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: const Text("stateful route title"),
        ),
        body: navigationShell,
      );
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _sectionNavigatorKey,
        routes: $appRoutes,
      ),
    ],
  );
}

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
  routes: [
    TypedShellRoute<CourseScreenRoute>(
      routes: [
        TypedGoRoute<CourseHomeRoute>(
          path: "course/:courseId/home",
        ),
        TypedGoRoute<CourseLecturesScreenRoute>(
          path: "course/:courseId/lectures",
        ),
        // Add this new route
        TypedGoRoute<VideoPlayerScreenRoute>(
          path: "course/:courseId/lecture/:lectureKey",
        ),
      ],
    ),
  ],
)

@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen(title: "Cool title here");
  }
}

@immutable
class CourseScreenRoute extends ShellRouteData {
  const CourseScreenRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    final courseId = int.parse(state.pathParameters['courseId']!);

    print("CourseScreenRoute builder");
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                CourseHomeRoute(courseId: courseId).go(context);
              },
            ),
            ListTile(
              title: const Text("Lectures"),
              onTap: () {
                Navigator.pop(context);
                CourseLecturesScreenRoute(courseId: courseId).go(context);
              },
            ),
          ],
        ),
      ),
      body: navigator,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
    );
  }
}

@immutable
class CourseHomeRoute extends GoRouteData {
  final int courseId;

  const CourseHomeRoute({required this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseHomeScreen(courseId: courseId);
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

