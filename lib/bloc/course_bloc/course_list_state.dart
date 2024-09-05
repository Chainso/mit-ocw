part of "course_bloc.dart";

@immutable
sealed class CourseListState extends Equatable {

}

class CourseListLoadingState extends CourseListState {
  @override
  List<Object?> get props => [];
}

class CourseListLoadedState extends CourseListState {
  final Map<int, FullCourseRun> courses;

  CourseListLoadedState(List<FullCourseRun> courseList) :
    courses = { for (var courseRun in courseList) courseRun.course.id : courseRun };

  @override
  List<Object?> get props => [courses];
}

class CourseListErrorState extends CourseListState {
  final String error;

  CourseListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

