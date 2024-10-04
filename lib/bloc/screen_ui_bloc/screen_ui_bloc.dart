import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'screen_ui_state.dart';
part 'screen_ui_event.dart';

class ScreenUiBloc extends Bloc<ScreenUiEvent, ScreenUiState> {
  ScreenUiBloc() : super(const ScreenUiState(fullscreen: false)) {
    on<ScreenUiSetFullscreenEvent>((event, emit) async {
      emit(ScreenUiState(fullscreen: event.fullscreen));
    });
  }
}
