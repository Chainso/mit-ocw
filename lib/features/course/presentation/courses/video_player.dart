import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mit_ocw/bloc/screen_ui_bloc/screen_ui_bloc.dart';

class VideoPlayer extends StatefulWidget {
  final String videoKey;
  final Duration? startPos;
  final bool fullscreen;
  final Function(YoutubeMetaData)? onEnded;
  final Function(Duration, Duration)? onPositionChanged;
  final Widget Function(BuildContext, Widget) builder;

  const VideoPlayer({
    super.key,
    required this.videoKey,
    this.startPos,
    this.fullscreen = false,
    this.onEnded,
    this.onPositionChanged,
    required this.builder
  });

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> with WidgetsBindingObserver {
  final Logger logger = Logger();

  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _initializeVideo();

    Timer.periodic(
      const Duration(seconds: 10),
      (timer) => _onPositionChanged()
    );
  }

  @override
  @mustCallSuper
  void didUpdateWidget(covariant VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    logger.i("Did change dependencies for video player");
    logger.i("Old video key: ${oldWidget.videoKey}, new video key: ${widget.videoKey}");
    logger.i("Old fullscreen: ${oldWidget.fullscreen}, new fullscreen: ${widget.fullscreen}");

    if (widget.videoKey != oldWidget.videoKey) {
      _youtubePlayerController.load(widget.videoKey);

      if (widget.startPos != null) {
        _youtubePlayerController.seekTo(widget.startPos!);
      }
    }

    if (widget.fullscreen != oldWidget.fullscreen) {
      _updateFullscreenState(widget.fullscreen);
    }
  }

  @override
  void dispose() {
    logger.i("Disposing video at position: ${_youtubePlayerController.value.position} out of ${_youtubePlayerController.value.metaData.duration}");
    _youtubePlayerController.dispose();

    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  Future<void> _initializeVideo() async {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        startAt: widget.startPos?.inSeconds ?? 0,
      ),
    );
  }

  void _onPositionChanged() {
    logger.i("Updating position to ${_youtubePlayerController.value.position} out of ${_youtubePlayerController.value.metaData.duration}");

    if (widget.onPositionChanged != null) {
      widget.onPositionChanged!(
        Duration(milliseconds: _youtubePlayerController.value.position.inMilliseconds),
        Duration(milliseconds: _youtubePlayerController.value.metaData.duration.inMilliseconds)
      );
    }
  }


  void _updateFullscreenState(bool fullscreen) {
    if (widget.fullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }

    context.read<ScreenUiBloc>().add(ScreenUiSetFullscreenEvent(fullscreen: fullscreen));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _onPositionChanged();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      },
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: _youtubePlayerController,
        onEnded: (metaData) {
          if (widget.onEnded != null) {
            widget.onEnded!(metaData);
          }
        },
      ),
      builder: widget.builder
    );
  }
}
