import 'package:drift/drift.dart';
import 'package:mit_ocw/features/course/data/course_preferences_repository.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/features/persistence/watch_history.dart';

part 'watch_history_repository.g.dart';


@DriftAccessor(
  tables: [LectureWatchHistory],
  queries: {
    "getLatestWatched":
        "SELECT * FROM "
        "(SELECT *, RANK() OVER (PARTITION BY coursenum "
            "ORDER BY CASE WHEN position / lecture_length < 0.98 THEN 1 ELSE 2 END, "
            "lecture_number DESC "
          ") as rank FROM lecture_watch_history) "
        "WHERE rank = 1 "
        "ORDER BY updated_at DESC",
    "getLatestWatchedForCourses":
        "SELECT * FROM "
        "(SELECT *, RANK() OVER (PARTITION BY coursenum "
            "ORDER BY CASE WHEN position / lecture_length < 0.98 THEN 1 ELSE 2 END, "
            "lecture_number DESC "
          ") as rank FROM lecture_watch_history "
          "WHERE coursenum IN ?) "
        "WHERE rank = 1 "
        "ORDER BY updated_at DESC",
  }
)
class WatchHistoryRepository extends DatabaseAccessor<MitOcwDatabase> with _$WatchHistoryRepositoryMixin {
  final CoursePreferencesRepository coursePreferencesRepository;

  WatchHistoryRepository({required MitOcwDatabase database, required this.coursePreferencesRepository}) : super(database);

  Future<LectureWatchHistoryData> upsertWatchHistory(
    String coursenum,
    String lectureKey,
    int lectureNumber,
    int position,
    int lectureLength
  ) async {
    return await db.transaction(() async {
      final watchHistory = await getWatchHistory(coursenum, lectureKey);

      if (watchHistory == null) {
        coursePreferencesRepository.enableContinueWatching(coursenum);

        final newWatchHistory = LectureWatchHistoryCompanion.insert(
          coursenum: coursenum,
          lectureKey: lectureKey,
          lectureNumber: lectureNumber,
          position: position,
          lectureLength: lectureLength
        );

        await into(db.lectureWatchHistory).insert(newWatchHistory);
      } else {
        final newWatchHistory = LectureWatchHistoryCompanion.insert(
          coursenum: coursenum,
          lectureKey: lectureKey,
          lectureNumber: lectureNumber,
          position: position,
          lectureLength: lectureLength,
          createdAt: Value(watchHistory.createdAt),
          updatedAt: Value(DateTime.now())
        );

        await update(db.lectureWatchHistory).replace(newWatchHistory);
      }

      return (await getWatchHistory(coursenum, lectureKey))!;
    });
  }

  Future<Map<String, LectureWatchHistoryData>> getWatchHistoryForCourse(String coursenum) async {
    final watchHistory = await (select(db.lectureWatchHistory)
      ..where((tbl) => tbl.coursenum.equals(coursenum)))
      .get();

    return Map.fromEntries(watchHistory.map((history) => MapEntry(history.lectureKey, history)));
  }

  Future<LectureWatchHistoryData?> getWatchHistory(String coursenum, String lectureKey) async {
    return await (select(db.lectureWatchHistory)
      ..where((tbl) => tbl.coursenum.equals(coursenum) & tbl.lectureKey.equals(lectureKey)))
      .getSingleOrNull();
  }

  Future<List<MapEntry<String, LectureWatchHistoryData>>> getLatestWatchedLectureByCourse() async {
  //   // Want to get the latest watched lecture for each course, want to get the entire lecture watch history point for it
    return await db.transaction(() async {
      final latestLectures = await getLatestWatched().get();

      return latestLectures.map((watchedLecture) {
        final lectureWatchHistory = LectureWatchHistoryData(
          coursenum: watchedLecture.coursenum,
          lectureKey: watchedLecture.lectureKey,
          lectureNumber: watchedLecture.lectureNumber,
          position: watchedLecture.position,
          lectureLength: watchedLecture.lectureLength,
          createdAt: watchedLecture.createdAt,
          updatedAt: watchedLecture.updatedAt
        );

        return MapEntry(watchedLecture.coursenum, lectureWatchHistory);
      }).toList();
    });
  }

  Future<Map<String, LectureWatchHistoryData>> getLatestWatchedLectureForCourses(List<String> coursenums) async {
  //   // Want to get the latest watched lecture for each course, want to get the entire lecture watch history point for it
    return await db.transaction(() async {
      final latestLectures = await getLatestWatchedForCourses(coursenums).get();

      return Map.fromEntries(latestLectures.map((watchedLecture) {
        final lectureWatchHistory = LectureWatchHistoryData(
          coursenum: watchedLecture.coursenum,
          lectureKey: watchedLecture.lectureKey,
          lectureNumber: watchedLecture.lectureNumber,
          position: watchedLecture.position,
          lectureLength: watchedLecture.lectureLength,
          createdAt: watchedLecture.createdAt,
          updatedAt: watchedLecture.updatedAt
        );

        return MapEntry(watchedLecture.coursenum, lectureWatchHistory);
      }));
    });
  }
}
