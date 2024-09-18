import 'package:drift/drift.dart';
import 'package:mit_ocw/features/persistence/database.dart';
import 'package:mit_ocw/features/persistence/playlist.dart';

part 'playlist_repository.g.dart';

const _defaultPlaylistName = "Default";

@DriftAccessor(tables: [Playlist, PlaylistCourse])
class PlaylistRepository extends DatabaseAccessor<MitOcwDatabase> with _$PlaylistRepositoryMixin {
  PlaylistRepository({required MitOcwDatabase database}) : super(database);

  Future<PlaylistWithCourses> addCourseToDefaultPlaylist(String coursenum) async {
    return await addCourse(_defaultPlaylistName, coursenum);
  }

  Future<PlaylistWithCourses> addCourse(String name, String coursenum) async {
    return await db.transaction(() async {
      var playlist = await getPlaylist(name) ?? await createPlaylist(name);

      final playlistCourse = PlaylistCourseCompanion(
        playlistId: Value(playlist.id),
        coursenum: Value(coursenum),
      );

      final existingPlaylistCourse = await getPlaylistCourse(playlist.id, coursenum);

      if (existingPlaylistCourse == null) {
        await into(db.playlistCourse).insert(playlistCourse);
      }

      final playlistWithCourses = await getPlaylistWithCourses(name);
      return playlistWithCourses!;
    });
  }

  Future<PlaylistData> createDefaultPlaylist() async {
    return await createPlaylist(_defaultPlaylistName);
  }

  Future<PlaylistData> createPlaylist(String name) async {
    final playlistToSave = PlaylistCompanion(
      name: Value(name),
    );

    await into(db.playlist).insert(playlistToSave);

    final playlist = await getPlaylist(name);
    return playlist!;
  }

  Future<PlaylistData?> getDefaultPlaylist() async {
    return await getPlaylist(_defaultPlaylistName);
  }

  Future<PlaylistData?> getPlaylist(String name) async {
    return await (select(db.playlist)..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
  }

  Future<PlaylistCourseData?> getPlaylistCourse(int playlistId, String coursenum) async {
    return await (select(db.playlistCourse)
      ..where((tbl) => tbl.playlistId.equals(playlistId) & tbl.coursenum.equals(coursenum)))
      .getSingleOrNull();
  }

  Future<PlaylistWithCourses?> getDefaultPlaylistWithCourses() async {
    return await getPlaylistWithCourses(_defaultPlaylistName);
  }

  Future<PlaylistWithCourses?> getPlaylistWithCourses(String name) async {
    final playlistWithCoursesQuery = select(db.playlist)
      .join([
        leftOuterJoin(
          db.playlistCourse,
          db.playlistCourse.playlistId.equalsExp(db.playlist.id)
        )
      ])
      ..where(db.playlist.name.equals(name));

    final playlistWithCourses = await playlistWithCoursesQuery.get();

    if (playlistWithCourses.isEmpty) {
      return null;
    }

    final playlistWithCoursesData = PlaylistWithCourses(
      name: name,
      coursenums: []
    );

    for (final playlistCourseRow in playlistWithCourses) {
      final playlistCourse = playlistCourseRow.readTableOrNull(db.playlistCourse);

      if (playlistCourse != null) {
        playlistWithCoursesData.coursenums.add(playlistCourse.coursenum);
      }
    }

    return playlistWithCoursesData;
  }

  Future<PlaylistWithCourses?> removeCourseFromDefaultPlaylist(String coursenum) async {
    return await removeCourse(_defaultPlaylistName, coursenum);
  }

  Future<PlaylistWithCourses?> removeCourse(String playlistName, String coursenum) async {
    return await db.transaction(() async {
      final playlist = await getPlaylist(playlistName);

      if (playlist == null) {
        return null;
      }

      await (delete(db.playlistCourse)
        ..where((tbl) => tbl.playlistId.equals(playlist.id) & tbl.coursenum.equals(coursenum)))
        .go();

      final playlistWithCourses = await getPlaylistWithCourses(playlistName);
      return playlistWithCourses;
    });
  }
}

class PlaylistWithCourses {
  final String name;
  final List<String> coursenums;

  PlaylistWithCourses({required this.name, required this.coursenums});
}

PlaylistWithCourses createDefaultPlaylistWithCourses() {
  return PlaylistWithCourses(name: _defaultPlaylistName, coursenums: []);
}
