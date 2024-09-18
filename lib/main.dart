import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mit_ocw/bloc/library_bloc/library_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/data/playlist_repository.dart';
import 'package:mit_ocw/features/course/data/user_data_repository.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/routes.dart';

final _router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: $appRoutes
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final database = MitOcwDatabase();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CourseRepository>(
          create: (context) => CourseRepository(),
        ),
        RepositoryProvider<PlaylistRepository>(
          create: (context) => PlaylistRepository(database: database),
        ),
      ],
      child: BlocProvider<LibraryBloc>(
        create: (context) => LibraryBloc(context.read<PlaylistRepository>())
            ..add(const LibraryLoadEvent()),
        child: MaterialApp.router(
          title: 'MIT OpenCourseWare',
          routerConfig: _router,
          theme: ThemeData.dark().copyWith(
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            textTheme: const TextTheme(
              headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(color: Colors.white70),
              titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          builder: (context, child) {
            return SafeAreaWrapper(child: child!);
          },
        )
      )
    );
  }
}

class SafeAreaWrapper extends StatelessWidget {
  final Widget child;

  const SafeAreaWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
