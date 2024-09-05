part of "lecture_bloc.dart";

@immutable
abstract class LectureListEvent extends Equatable {
  const LectureListEvent();
}

class LectureListLoadEvent extends LectureListEvent {
  final String coursenum;

  LectureListLoadEvent(this.coursenum);

  @override
  List<String> get props => [coursenum];
}
