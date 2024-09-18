import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/features/course/data/playlist_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'library_state.dart';
part 'library_event.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final logger = Logger();
  final PlaylistRepository _playlistRepository;

  LibraryBloc(this._playlistRepository) : super(LibraryWaitingState(library: createDefaultPlaylistWithCourses())) {
    on<LibraryLoadEvent>((event, emit) async {
      emit(LibraryLoadingState(library: state.library));

      try {
        final library = await _playlistRepository.getDefaultPlaylistWithCourses() ?? createDefaultPlaylistWithCourses();
        emit(LibraryLoadedState(library: library));
      } catch (e) {
        logger.e("Error loading library", error: e);
        emit(LibraryLoadErrorState(library: state.library, error: e));
      }
    });

    on<LibraryAddCourseEvent>((event, emit) async {
      emit(LibraryLoadingState(library: state.library));

      try {
        final library = await _playlistRepository.addCourseToDefaultPlaylist(event.coursenum);
        emit(LibraryCourseAddedState(
          library: library,
          coursenum: event.coursenum,
          isUndo: event.isUndo,
        ));
      } catch (e) {
        logger.e("Error adding course ${event.coursenum} to library", error: e);
        emit(LibraryAddCourseErrorState(
          library: state.library,
          error: e,
          coursenum: event.coursenum,
        ));
      }
    });

    on<LibraryRemoveCourseEvent>((event, emit) async {
      emit(LibraryLoadingState(library: state.library));

      try {
        final library = await _playlistRepository.removeCourseFromDefaultPlaylist(event.coursenum) ?? createDefaultPlaylistWithCourses();
        emit(LibraryCourseRemovedState(
          library: library,
          coursenum: event.coursenum,
          isUndo: event.isUndo,
        ));
      } catch (e) {
        logger.e("Error removing course ${event.coursenum} from library", error: e);
        emit(LibraryRemoveCourseErrorState(
          library: state.library,
          error: e,
          coursenum: event.coursenum,
        ));
      }
    });
  }
}

