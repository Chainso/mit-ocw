// GoRouter configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/features/course/presentation/course_screen.dart';
import 'package:mit_ocw/home.dart';

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
          title: const Text("stateful route title"),
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
    TypedGoRoute<CourseScreenRoute>(
      path: 'course/:courseId',
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
class CourseScreenRoute extends GoRouteData {
  const CourseScreenRoute({required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseScreen(courseId: courseId);
  }
}

