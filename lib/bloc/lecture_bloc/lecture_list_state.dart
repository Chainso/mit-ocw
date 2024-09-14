part of "lecture_bloc.dart";

@immutable
sealed class LectureListState extends Equatable {

}

class LectureListLoadingState extends LectureListState {
  @override
  List<Object?> get props => [];
}

class LectureListLoadedState extends LectureListState {
  final List<Lecture> lectures;

  LectureListLoadedState({required this.lectures});

  @override
  List<Object?> get props => [lectures];
}

class LectureListErrorState extends LectureListState {
  final Object error;

  LectureListErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

