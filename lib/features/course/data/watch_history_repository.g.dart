// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_history_repository.dart';

// ignore_for_file: type=lint
mixin _$WatchHistoryRepositoryMixin on DatabaseAccessor<MitOcwDatabase> {
  $CoursePreferencesTable get coursePreferences =>
      attachedDatabase.coursePreferences;
  $LectureWatchHistoryTable get lectureWatchHistory =>
      attachedDatabase.lectureWatchHistory;
  Selectable<GetLatestWatchedResult> getLatestWatched() {
    return customSelect(
        'SELECT * FROM (SELECT *, RANK()OVER (PARTITION BY coursenum ORDER BY CASE WHEN position / lecture_length < 0.98 THEN 1 ELSE 2 END, lecture_number DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS rank FROM lecture_watch_history) WHERE rank = 1 ORDER BY updated_at DESC',
        variables: [],
        readsFrom: {
          lectureWatchHistory,
        }).map((QueryRow row) => GetLatestWatchedResult(
          coursenum: row.read<String>('coursenum'),
          lectureKey: row.read<String>('lecture_key'),
          lectureNumber: row.read<int>('lecture_number'),
          position: row.read<int>('position'),
          lectureLength: row.read<int>('lecture_length'),
          createdAt: row.read<DateTime>('created_at'),
          updatedAt: row.read<DateTime>('updated_at'),
          rank: row.read<int>('rank'),
        ));
  }

  Selectable<GetLatestWatchedForCoursesResult> getLatestWatchedForCourses(
      List<String> var1) {
    var $arrayStartIndex = 1;
    final expandedvar1 = $expandVar($arrayStartIndex, var1.length);
    $arrayStartIndex += var1.length;
    return customSelect(
        'SELECT * FROM (SELECT *, RANK()OVER (PARTITION BY coursenum ORDER BY CASE WHEN position / lecture_length < 0.98 THEN 1 ELSE 2 END, lecture_number DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW EXCLUDE NO OTHERS) AS rank FROM lecture_watch_history WHERE coursenum IN ($expandedvar1)) WHERE rank = 1 ORDER BY updated_at DESC',
        variables: [
          for (var $ in var1) Variable<String>($)
        ],
        readsFrom: {
          lectureWatchHistory,
        }).map((QueryRow row) => GetLatestWatchedForCoursesResult(
          coursenum: row.read<String>('coursenum'),
          lectureKey: row.read<String>('lecture_key'),
          lectureNumber: row.read<int>('lecture_number'),
          position: row.read<int>('position'),
          lectureLength: row.read<int>('lecture_length'),
          createdAt: row.read<DateTime>('created_at'),
          updatedAt: row.read<DateTime>('updated_at'),
          rank: row.read<int>('rank'),
        ));
  }
}

class GetLatestWatchedResult {
  final String coursenum;
  final String lectureKey;
  final int lectureNumber;
  final int position;
  final int lectureLength;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int rank;
  GetLatestWatchedResult({
    required this.coursenum,
    required this.lectureKey,
    required this.lectureNumber,
    required this.position,
    required this.lectureLength,
    required this.createdAt,
    required this.updatedAt,
    required this.rank,
  });
}

class GetLatestWatchedForCoursesResult {
  final String coursenum;
  final String lectureKey;
  final int lectureNumber;
  final int position;
  final int lectureLength;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int rank;
  GetLatestWatchedForCoursesResult({
    required this.coursenum,
    required this.lectureKey,
    required this.lectureNumber,
    required this.position,
    required this.lectureLength,
    required this.createdAt,
    required this.updatedAt,
    required this.rank,
  });
}
