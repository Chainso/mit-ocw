part of "course_bloc.dart";

@immutable
sealed class CourseState extends Equatable {
  const CourseState();
}

class CourseWaitingState extends CourseState {
  const CourseWaitingState();

  @override
  List<Object?> get props => [];
}

class CourseLoadingState extends CourseState {
  final String coursenum;

  const CourseLoadingState({required this.coursenum});

  @override
  List<Object?> get props => [coursenum];
}

class CourseLoadedState extends CourseState {
  final FullCourseRun course;

  const CourseLoadedState({required this.course});

  @override
  List<Object?> get props => [course];
}

class CourseNotFoundState extends CourseState {
  final String coursenum;

  const CourseNotFoundState({required this.coursenum});

  @override
  List<Object?> get props => [coursenum];
}

class CourseErrorState extends CourseState {
  final String coursenum;
  final Object error;

  const CourseErrorState({required this.coursenum, required this.error});

  @override
  List<Object?> get props => [coursenum, error];
}

