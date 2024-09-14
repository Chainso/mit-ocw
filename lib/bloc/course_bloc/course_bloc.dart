import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'course_state.dart';
part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final logger = Logger();
  final CourseRepository _courseRepository;

  CourseBloc(this._courseRepository) : super(const CourseWaitingState()) {
    on<CourseLoadEvent>((event, emit) async {
      emit(CourseLoadingState(coursenum: event.coursenum));

      try {
        final course = await _courseRepository.getCourse(event.coursenum);

        if (course == null) {
          emit(CourseNotFoundState(coursenum: event.coursenum));
        } else {
          emit(CourseLoadedState(course: course));
        }
      } catch (e) {
        logger.e("Error loading course ${event.coursenum}", error: e);
        emit(CourseErrorState(error: e, coursenum: event.coursenum));
      }
    });
  }
}
