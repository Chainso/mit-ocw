import 'package:drift/drift.dart';
import 'package:mit_ocw/features/persistence/course_preferences.dart';
import 'package:mit_ocw/features/persistence/database.dart';

part 'course_preferences_repository.g.dart';


@DriftAccessor(tables: [CoursePreferences])
class CoursePreferencesRepository extends DatabaseAccessor<MitOcwDatabase> with _$CoursePreferencesRepositoryMixin {
  CoursePreferencesRepository({required MitOcwDatabase database}) : super(database);

  Future<CoursePreference> createCoursePreferences(
    String coursenum,
    bool? showInContinueWatching
  ) async {
    return await db.transaction(() async {
      final coursePreferences = await getCoursePreferences(coursenum);

      if (coursePreferences == null) {
        final newCoursePreferences = CoursePreferencesCompanion.insert(
          coursenum: coursenum,
          showInContinueWatching: Value.absentIfNull(showInContinueWatching)
        );

        await into(db.coursePreferences).insert(newCoursePreferences);
      } else {
        final newCoursePreferences = CoursePreferencesCompanion.insert(
          coursenum: coursenum,
          showInContinueWatching: Value.absentIfNull(showInContinueWatching),
          createdAt: Value(coursePreferences.createdAt),
          updatedAt: Value(DateTime.now())
        );

        await update(db.coursePreferences).replace(newCoursePreferences);
      }

      return (await getCoursePreferences(coursenum))!;
    });
  }

  Future<CoursePreference> createCoursePreferencesIfNotExists(
    String coursenum
  ) async {
    return await db.transaction(() async {
      final coursePreferences = CoursePreferencesCompanion.insert(
        coursenum: coursenum
      );

      return await into(db.coursePreferences).insertReturning(
        coursePreferences,
        mode: InsertMode.insertOrAbort
      );
    });
  }

  Future<CoursePreference?> getCoursePreferences(String coursenum) async {
    return await (select(db.coursePreferences)
      ..where((tbl) => tbl.coursenum.equals(coursenum)))
      .getSingleOrNull();
  }
}

