part of "screen_ui_bloc.dart";

@immutable
class ScreenUiState extends Equatable {
  final bool fullscreen;

  const ScreenUiState({required this.fullscreen});

  @override
  List<Object?> get props => [fullscreen];
}
