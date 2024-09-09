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
          path: "/courses/:courseId",
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
                        TypedGoRoute<VideoPlayerScreenRoute>(
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
  final int courseId;
  const CourseHomeScreenRedirectRoute({required this.courseId});

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    print("CourseHomeScreenRedirectRoute: Redirecting to /courses/$courseId/home");
    print("CourseHomeScreenRedirectRoute: courseId = $courseId");
    print("CourseHomeScreenRedirectRoute: fullPath = ${state.fullPath}");
    print("CourseHomeScreenRedirectRoute: pathParameters = ${state.pathParameters}");

    if (state.fullPath == location) {
      return CourseHomeScreenRoute(courseId: courseId).location;
    }

    return null;
  }
}

@immutable
class CourseScreenRoute extends StatefulShellRouteData {
  const CourseScreenRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    print("CourseScreenRoute: currentIndex = ${navigationShell.currentIndex}");
    print("CourseScreenRoute: currentLocation = ${state.fullPath}");
    print("CourseScreenRoute: pathParameters = ${state.pathParameters}");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: navigationShell,
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
      ),
    );
  }
}

@immutable
class CourseHomeBranch extends StatefulShellBranchData {
  const CourseHomeBranch();
}

@immutable
class CourseHomeScreenRoute extends GoRouteData {
  final int courseId;

  const CourseHomeScreenRoute({required this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    print("Building CourseHomeScreenRoute for courseId: $courseId");
    return CourseDetailScreen(courseId: courseId);
  }
}

@immutable
class CourseLecturesBranch extends StatefulShellBranchData {
  const CourseLecturesBranch();
}

@immutable
class CourseLecturesScreenRoute extends GoRouteData {
  const CourseLecturesScreenRoute({required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    print("Building CourseLecturesScreenRoute for courseId: $courseId");
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
class MyLibraryScreenBranch extends StatefulShellBranchData {
  const MyLibraryScreenBranch();
}

@immutable
class MyLibraryScreenRoute extends GoRouteData {
  const MyLibraryScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Text("My Library");
  }
}