import 'package:drift/drift.dart';


class Playlist extends Table {
  @override
  List<Set<Column>> get uniqueKeys => [
    {name}
  ];

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PlaylistCourse extends Table {
  @override
  Set<Column> get primaryKey => {playlistId, coursenum};

  IntColumn get playlistId => integer().references(Playlist, #id)();
  TextColumn get coursenum => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

