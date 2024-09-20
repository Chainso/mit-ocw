import 'package:drift/drift.dart';


class CoursePreferences extends Table {
  @override
  Set<Column> get primaryKey => {coursenum};

  TextColumn get coursenum => text()();
  BoolColumn get showInContinueWatching => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

