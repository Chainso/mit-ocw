import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_ocw/features/course/data/course_repository.dart';
import 'package:mit_ocw/features/course/domain/course.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'course_list_state.dart';
part 'course_list_event.dart';

class CourseBloc extends Bloc<CourseListEvent, CourseListState> {
  final CourseRepository _courseRepository;

  CourseBloc(this._courseRepository) : super(CourseListLoadingState()) {
    on<CourseListLoadEvent>((event, emit) async {
      emit(CourseListLoadingState());
      try {
        final courseList = await _courseRepository.getCourses();
        emit(CourseListLoadedState(courseList));
      } catch (e) {
        emit(CourseListErrorState(e.toString()));
      }
    });
  }
}
