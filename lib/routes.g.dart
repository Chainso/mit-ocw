// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $rootRoute,
    ];

RouteBase get $rootRoute => StatefulShellRouteData.$route(
      factory: $RootRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeScreenRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/search',
              factory: $SearchScreenRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            StatefulShellRouteData.$route(
              factory: $CourseScreenRouteExtension._fromState,
              branches: [
                StatefulShellBranchData.$branch(
                  routes: [
                    GoRouteData.$route(
                      path: '/',
                      factory: $HomeRedirectRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: '/courses/:courseId',
                      factory:
                          $CourseScreenHomeRedirectRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'home',
                          factory: $CourseHomeScreenRouteExtension._fromState,
                        ),
                        GoRouteData.$route(
                          path: 'lectures',
                          factory:
                              $CourseLecturesScreenRouteExtension._fromState,
                          routes: [
                            GoRouteData.$route(
                              path: ':lectureKey',
                              factory:
                                  $VideoPlayerScreenRouteExtension._fromState,
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
      ],
    );

extension $RootRouteExtension on RootRoute {
  static RootRoute _fromState(GoRouterState state) => const RootRoute();
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

extension $CourseScreenRouteExtension on CourseScreenRoute {
  static CourseScreenRoute _fromState(GoRouterState state) =>
      const CourseScreenRoute();
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

extension $CourseScreenHomeRedirectRouteExtension
    on CourseScreenHomeRedirectRoute {
  static CourseScreenHomeRedirectRoute _fromState(GoRouterState state) =>
      CourseScreenHomeRedirectRoute(
        courseId: int.parse(state.pathParameters['courseId']!),
      );

  String get location => GoRouteData.$location(
        '/courses/${Uri.encodeComponent(courseId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CourseHomeScreenRouteExtension on CourseHomeScreenRoute {
  static CourseHomeScreenRoute _fromState(GoRouterState state) =>
      CourseHomeScreenRoute(
        courseId: int.parse(state.pathParameters['courseId']!),
      );

  String get location => GoRouteData.$location(
        '/courses/${Uri.encodeComponent(courseId.toString())}/home',
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
        '/courses/${Uri.encodeComponent(courseId.toString())}/lectures',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $VideoPlayerScreenRouteExtension on VideoPlayerScreenRoute {
  static VideoPlayerScreenRoute _fromState(GoRouterState state) =>
      VideoPlayerScreenRoute(
        courseId: int.parse(state.pathParameters['courseId']!),
        lectureKey: state.pathParameters['lectureKey']!,
      );

  String get location => GoRouteData.$location(
        '/courses/${Uri.encodeComponent(courseId.toString())}/lectures/${Uri.encodeComponent(lectureKey)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
