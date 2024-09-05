// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeScreenRoute,
    ];

RouteBase get $homeScreenRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeScreenRouteExtension._fromState,
      routes: [
        ShellRouteData.$route(
          factory: $CourseScreenRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'course/:courseId/home',
              factory: $CourseHomeRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'course/:courseId/lectures',
              factory: $CourseLecturesScreenRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeScreenRouteExtension on HomeScreenRoute {
  static HomeScreenRoute _fromState(GoRouterState state) => HomeScreenRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CourseScreenRouteExtension on CourseScreenRoute {
  static CourseScreenRoute _fromState(GoRouterState state) =>
      const CourseScreenRoute();
}

extension $CourseHomeRouteExtension on CourseHomeRoute {
  static CourseHomeRoute _fromState(GoRouterState state) => CourseHomeRoute(
        courseId: int.parse(state.pathParameters['courseId']!),
      );

  String get location => GoRouteData.$location(
        '/course/${Uri.encodeComponent(courseId.toString())}/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CourseLecturesScreenRouteExtension on CourseLecturesScreenRoute {
  static CourseLecturesScreenRoute _fromState(GoRouterState state) =>
      CourseLecturesScreenRoute(
        courseId: int.parse(state.pathParameters['courseId']!),
      );

  String get location => GoRouteData.$location(
        '/course/${Uri.encodeComponent(courseId.toString())}/lectures',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
