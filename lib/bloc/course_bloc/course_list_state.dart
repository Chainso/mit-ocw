part of "course_bloc.dart";

@immutable
abstract class CourseListState extends Equatable {

}

class CourseListLoadingState extends CourseListState {
  @override
  List<Object?> get props => [];
}

class CourseListLoadedState extends CourseListState {
  final List<Course> courses;

  CourseListLoadedState(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CourseListErrorState extends CourseListState {
  final String error;

  CourseListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
