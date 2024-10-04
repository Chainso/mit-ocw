part of "screen_ui_bloc.dart";

@immutable
abstract class ScreenUiEvent extends Equatable {
  const ScreenUiEvent();

  @override
  List<Object?> get props => [];
}

class ScreenUiSetFullscreenEvent extends ScreenUiEvent {
  final bool fullscreen;

  const ScreenUiSetFullscreenEvent({required this.fullscreen});

  @override
  List<Object?> get props => [fullscreen];
}
