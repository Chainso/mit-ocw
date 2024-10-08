import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'lecture_list_state.dart';
part 'lecture_list_event.dart';

class LectureBloc extends Bloc<LectureListEvent, LectureListState> {
  final logger = Logger();
  final CourseRepository _courseRepository;

  LectureBloc(this._courseRepository) : super(LectureListLoadingState()) {
    on<LectureListLoadEvent>((event, emit) async {
      emit(LectureListLoadingState());
      try {
        final lectureList = await _courseRepository.getLectureVideos(event.coursenum);
        emit(LectureListLoadedState(lectures: lectureList));
      } catch (e) {
        logger.e("Error loading lecture list for course ${event.coursenum}", error: e);
        emit(LectureListErrorState(error: e));
      }
    });
  }
}
