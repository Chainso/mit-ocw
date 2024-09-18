part of "library_bloc.dart";

@immutable
abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class LibraryLoadEvent extends LibraryEvent {
  const LibraryLoadEvent();
}

class LibrarySingleCourseEvent extends LibraryEvent {
  final String coursenum;

  const LibrarySingleCourseEvent({required this.coursenum});

  @override
  List<Object?> get props => [coursenum];
}

class LibraryAddCourseEvent extends LibrarySingleCourseEvent {
  final bool isUndo;

  const LibraryAddCourseEvent({required super.coursenum, this.isUndo = false});

  @override
  List<Object?> get props => super.props + [isUndo];
}

class LibraryRemoveCourseEvent extends LibrarySingleCourseEvent {
  final bool isUndo;

  const LibraryRemoveCourseEvent({required super.coursenum, this.isUndo = false});

  @override
  List<Object?> get props => super.props + [isUndo];
}
