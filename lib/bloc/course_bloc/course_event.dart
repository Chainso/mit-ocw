part of "course_bloc.dart";

@immutable
abstract class CourseEvent extends Equatable {
  final String coursenum;

  const CourseEvent({required this.coursenum});
}

class CourseLoadEvent extends CourseEvent {
  const CourseLoadEvent({required super.coursenum});

  @override
  List<Object?> get props => [coursenum];
}
