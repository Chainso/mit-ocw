import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:mit_ocw/features/course/data/course_preferences_repository.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/features/persistence/watch_history.dart';

part 'watch_history_repository.g.dart';


@DriftAccessor(tables: [LectureWatchHistory])
class WatchHistoryRepository extends DatabaseAccessor<MitOcwDatabase> with _$WatchHistoryRepositoryMixin {
  final CoursePreferencesRepository coursePreferencesRepository;

  WatchHistoryRepository({required MitOcwDatabase database, required this.coursePreferencesRepository}) : super(database);

  Future<LectureWatchHistoryData> upsertWatchHistory(
    String coursenum,
    String lectureKey,
    int position,
    int lectureLength
  ) async {
    return await db.transaction(() async {
      final watchHistory = await getWatchHistory(coursenum, lectureKey);

      if (watchHistory == null) {
        coursePreferencesRepository.createCoursePreferencesIfNotExists(coursenum);

        final newWatchHistory = LectureWatchHistoryCompanion.insert(
          coursenum: coursenum,
          lectureKey: lectureKey,
          position: position,
          lectureLength: lectureLength
        );

        await into(db.lectureWatchHistory).insert(newWatchHistory);
      } else {
        final newWatchHistory = LectureWatchHistoryCompanion.insert(
          coursenum: coursenum,
          lectureKey: lectureKey,
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

  // Future<Map<CourseLectureKey, LectureWatchHistoryData>> getLatestWatchedLectureByCourse() async {
  //   // Want to get the latest watched lecture for each course, want to get the entire lecture watch history point for it
  //   return await db.transaction(() async {
  //     final latestByLecture = await db.customSelect(
  //       'SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY coursenumlecture_watch_history WHERE (coursenum, updatedAt) IN (SELECT coursenum, MAX(updatedAt) FROM lecture_watch_history GROUP BY coursenum)'
  //     ).get();
  //     final lectureHistorySubquery = alias(db.lectureWatchHistory, 'lectureHistorySubquery');
  //     final orderedCourseWatchesByGroup = await (select(lectureHistorySubquery)
  //       ..groupBy([lectureHistorySubquery.coursenum])
  //       ..orderBy([
  //         OrderingTerm(expression: lectureHistorySubquery.updatedAt, mode: OrderingMode.desc)
  //       ]))
  //       .get();
  //     final query = select(db.lectureWatchHistory)
  //       ..groupBy([db.lectureWatchHistory.coursenum])
  //       ..orderBy([
  //         OrderingTerm(expression: db.lectureWatchHistory.updatedAt, mode: OrderingMode.desc)
  //       ]);
  //   });
  // }
}

class CourseLectureKey extends Equatable {
  final String coursenum;
  final String lectureKey;

  const CourseLectureKey({required this.coursenum, required this.lectureKey});

  @override
  List<Object> get props => [coursenum, lectureKey];
}
