part of "library_bloc.dart";

@immutable
sealed class LibraryState extends Equatable {
  final PlaylistWithCourses library;

  const LibraryState({required this.library});

  @override
  List<Object?> get props => [library];
}

class LibraryWaitingState extends LibraryState {
  const LibraryWaitingState({required super.library});
}

class LibraryLoadingState extends LibraryWaitingState {
  const LibraryLoadingState({required super.library});
}

class LibraryLoadedState extends LibraryState {
  const LibraryLoadedState({required super.library});
}

class LibrarySingleCourseState extends LibraryLoadedState {
  final String coursenum;

  const LibrarySingleCourseState({required super.library, required this.coursenum});

  @override
  List<Object?> get props => [library, coursenum];
}

class LibraryCourseAddedState extends LibrarySingleCourseState {
  final bool isUndo;

  const LibraryCourseAddedState({required super.library, required super.coursenum, required this.isUndo});

  @override
  List<Object?> get props => super.props + [isUndo];
}

class LibraryCourseRemovedState extends LibrarySingleCourseState {
  final bool isUndo;

  const LibraryCourseRemovedState({required super.library, required super.coursenum, required this.isUndo});

  @override
  List<Object?> get props => super.props + [isUndo];
}

abstract class LibraryErrorState extends LibraryState {
  final Object error;

  const LibraryErrorState({required super.library, required this.error});

  @override
  List<Object?> get props => [library, error];
}

class LibraryLoadErrorState extends LibraryErrorState {
  const LibraryLoadErrorState({required super.library, required super.error});
}

class LibraryAddCourseErrorState extends LibraryErrorState {
  final String coursenum;
  final bool? isUndo;

  const LibraryAddCourseErrorState({required super.library, required super.error, required this.coursenum, this.isUndo});

  @override
  List<Object?> get props => [library, error, coursenum, isUndo];
}

class LibraryRemoveCourseErrorState extends LibraryErrorState {
  final String coursenum;
  final bool? isUndo;

  const LibraryRemoveCourseErrorState({required super.library, required super.error, required this.coursenum, this.isUndo});

  @override
  List<Object?> get props => [library, error, coursenum, isUndo];
}

