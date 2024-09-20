import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:mit_ocw/features/persistence/course_preferences.dart';
import 'package:mit_ocw/features/persistence/playlist.dart';
import 'package:mit_ocw/features/persistence/watch_history.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Playlist, PlaylistCourse, CoursePreferences, LectureWatchHistory])
class MitOcwDatabase extends _$MitOcwDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  MitOcwDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'mit_ocw.db');
  }
}
