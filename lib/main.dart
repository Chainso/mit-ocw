import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/bloc/course_bloc/course_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [rootRoute()],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 // await FlutterDownloader.initialize(
  //  debug: true, // optional: set to false to disable printing logs to console (default: true)
 //   ignoreSsl: true // option: set to false to disable working with http links (default: false)
//  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CourseRepository>(
          create: (context) => CourseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CourseBloc>(
            create: (context) => CourseBloc(
              context.read<CourseRepository>(),
            )..add(CourseListLoadEvent()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          routerConfig: _router,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
