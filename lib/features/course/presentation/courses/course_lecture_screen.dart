import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/bloc/lecture_bloc/lecture_bloc.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:mit_ocw/config/ocw_config.dart';

class CourseLectureScreen extends StatefulWidget {
  final String coursenum;
  final String lectureKey;
  final int lectureNumber;

  const CourseLectureScreen({
    super.key,
    required this.coursenum,
    required this.lectureKey,
    required this.lectureNumber
  });

  @override
  _CourseLectureScreenState createState() => _CourseLectureScreenState();
}

class _CourseLectureScreenState extends State<CourseLectureScreen> with WidgetsBindingObserver {
  final Logger logger = Logger();

  YoutubePlayerController? _youtubePlayerController;
  final Dio _dio = Dio();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _initializeVideo();

    Timer.periodic(
      const Duration(seconds: 10),
      (timer) => updateWatchHistory()
    );
  }

  void updateWatchHistory() {
    if (_youtubePlayerController != null
      && _youtubePlayerController!.value.position.inMilliseconds > 0) {
      logger.i("Updating position to ${_youtubePlayerController!.value.position} out of ${_youtubePlayerController!.value.metaData.duration}");
      context.read<WatchHistoryRepository>().upsertWatchHistory(
        widget.coursenum,
        widget.lectureKey,
        widget.lectureNumber,
        _youtubePlayerController!.value.position.inMilliseconds,
        _youtubePlayerController!.value.metaData.duration.inMilliseconds
      );
    }
  }

  @override
  void dispose() {
    if (_youtubePlayerController != null) {
      logger.i("Disposing video at position: ${_youtubePlayerController!.value.position} out of ${_youtubePlayerController!.value.metaData.duration}");
      _youtubePlayerController?.dispose();
    }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.i("AppLifecycleState changed: $state");
    updateWatchHistory();
  }

  Future<void> _initializeVideo() async {
    final lectureWebpageUrl = '$ocwUrl/${widget.lectureKey}';
    
    try {
      final response = await _dio.get(lectureWebpageUrl);
      if (response.statusCode == 200) {
        final document = parser.parse(response.data);
        final videoPlayerDiv = document.querySelector('.video-js');
        if (videoPlayerDiv != null) {
          final dataSetup = videoPlayerDiv.attributes['data-setup'];
          if (dataSetup != null) {
            final jsonData = json.decode(dataSetup);
            final sources = jsonData['sources'] as List<dynamic>;
            if (sources.isNotEmpty) {
              final youtubeLink = sources[0]['src'] as String;
              final videoId = YoutubePlayer.convertUrlToId(youtubeLink);
              if (videoId != null) {
                if (mounted) {
                  final watchHistory = await context.read<WatchHistoryRepository>().getWatchHistory(widget.coursenum, widget.lectureKey);

                  Duration startPos = const Duration(milliseconds: 0);

                  if (watchHistory != null) {
                    final watchPercent = watchHistory.position / watchHistory.lectureLength;

                    // If watched more than 98%, start from beginning
                    if (watchPercent < 0.98) {
                      startPos = Duration(milliseconds: watchHistory.position);
                    }
                  }

                  setState(() {
                    _youtubePlayerController = YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                        startAt: startPos.inSeconds,
                      ),
                    );
                  });
                }

                return;
              }
            }
          }
        }
        setState(() {
          _errorMessage = 'Unable to find video for this lecture.';
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load lecture page.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching lecture page: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LectureBloc, LectureListState>(
      builder: (context, lectureListState) {
        switch (lectureListState) {
          case LectureListLoadingState _:
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          case LectureListErrorState _:
            return const Expanded(
              child: Center(
                child: Text(
                  "Error loading lecture, please try again",
                  style: TextStyle(color: Colors.white)
                )
              )
            );
          case LectureListLoadedState loadedLectures:
            final lecture = loadedLectures.lectures.firstWhereOrNull((element) => element.key == widget.lectureKey);
            
            if (lecture == null) {
              return const Expanded(
                child: Center(
                  child: Text(
                    "Error loading lecture, please try again",
                    style: TextStyle(color: Colors.white)
                  )
                )
              );
            }

            return Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [ 
                        Center(
                          child: _youtubePlayerController != null
                              ? YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: _youtubePlayerController!,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.blueAccent,
                                  onEnded: (metaData) {
                                    logger.i("Video ended");
                                    updateWatchHistory();
                                  },
                                ),
                                builder: (context, player) {
                                  return player;
                                }
                              )
                              : _errorMessage != null
                                  ? Text(_errorMessage!, style: const TextStyle(color: Colors.white))
                                  : const CircularProgressIndicator(),
                        ),
                        // const SizedBox(height: 12),
                        // Padding(                        
                        //   padding: const EdgeInsets.only(left: 16, right: 16),
                        //   child: Text(
                        //     lecture.title,
                        //     style: Theme.of(context).textTheme.titleMedium,
                        //   )
                        // ),
                        // const SizedBox(height: 24),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 16, right: 16),
                        //   child: MarkdownBody(
                        //     data: lecture.shortDescription ?? '',
                        //     styleSheet: MarkdownStyleSheet(
                        //       p: Theme.of(context).textTheme.bodyMedium,
                        //     ),
                        //   ),
                        // )
                      ]
                    )
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
