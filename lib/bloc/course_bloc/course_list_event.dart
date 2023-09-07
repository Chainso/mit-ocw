part of "course_bloc.dart";

@immutable
abstract class CourseListEvent extends Equatable {
  const CourseListEvent();
}

class CourseListLoadEvent extends CourseListEvent {
  @override
  List<Object?> get props => [];
}
