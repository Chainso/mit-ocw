import 'package:drift/drift.dart';
import 'package:mit_ocw/features/persistence/course_preferences.dart';


@TableIndex(name: "course_watch_history", columns: {#coursenum})
class LectureWatchHistory extends Table {
  @override
  Set<Column> get primaryKey => {coursenum, lectureKey};

  TextColumn get coursenum => text().references(CoursePreferences, #coursenum)();
  TextColumn get lectureKey => text()();
  IntColumn get position => integer()(); // Position in milliseconds
  IntColumn get lectureLength => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
