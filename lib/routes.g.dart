// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainShellRoute,
    ];

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
      factory: $MainShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $HomeRedirectRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/home',
              name: 'home',
              factory: $HomeScreenRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/search',
              name: 'search',
              factory: $SearchScreenRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/courses/:coursenum',
              name: 'course',
              factory: $CourseHomeScreenRedirectRouteExtension._fromState,
              routes: [
                StatefulShellRouteData.$route(
                  factory: $CourseRootShellRouteExtension._fromState,
                  branches: [
                    StatefulShellBranchData.$branch(
                      routes: [
                        GoRouteData.$route(
                          path: 'details',
                          name: 'course-details',
                          factory: $CourseRouteExtension._fromState,
                          routes: [
                            GoRouteData.$route(
                              path: 'lectures',
                              factory:
                                  $CourseLectureScreenRouteExtension._fromState,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/my-library',
              name: 'my-library',
              factory: $MyLibraryScreenRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

extension $HomeRedirectRouteExtension on HomeRedirectRoute {
  static HomeRedirectRoute _fromState(GoRouterState state) =>
      const HomeRedirectRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HomeScreenRouteExtension on HomeScreenRoute {
  static HomeScreenRoute _fromState(GoRouterState state) =>
      const HomeScreenRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchScreenRouteExtension on SearchScreenRoute {
  static SearchScreenRoute _fromState(GoRouterState state) => SearchScreenRoute(
        q: state.uri.queryParameters['q'],
      );

  String get location => GoRouteData.$location(
        '/search',
        queryParams: {
          if (q != null) 'q': q,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CourseHomeScreenRedirectRouteExtension
    on CourseHomeScreenRedirectRoute {
  static CourseHomeScreenRedirectRoute _fromState(GoRouterState state) =>
      CourseHomeScreenRedirectRoute(
        coursenum: state.pathParameters['coursenum']!,
      );

  String get location => GoRouteData.$location(
        '/courses/${Uri.encodeComponent(coursenum)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CourseRootShellRouteExtension on CourseRootShellRoute {
  static CourseRootShellRoute _fromState(GoRouterState state) =>
      const CourseRootShellRoute();
}

extension $CourseRouteExtension on CourseRoute {
  static CourseRoute _fromState(GoRouterState state) => CourseRoute(
        coursenum: state.pathParameters['coursenum']!,
      );

  String get location => GoRouteData.$location(
        '/courses/${Uri.encodeComponent(coursenum)}/details',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CourseLectureScreenRouteExtension on CourseLectureScreenRoute {
  static CourseLectureScreenRoute _fromState(GoRouterState state) =>
      CourseLectureScreenRoute(
        coursenum: state.pathParameters['coursenum']!,
        lectureNumber: int.parse(state.uri.queryParameters['lecture-number']!),
      );

  String get location => GoRouteData.$location(
        '/courses/${Uri.encodeComponent(coursenum)}/details/lectures',
        queryParams: {
          'lecture-number': lectureNumber.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyLibraryScreenRouteExtension on MyLibraryScreenRoute {
  static MyLibraryScreenRoute _fromState(GoRouterState state) =>
      const MyLibraryScreenRoute();

  String get location => GoRouteData.$location(
        '/my-library',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
