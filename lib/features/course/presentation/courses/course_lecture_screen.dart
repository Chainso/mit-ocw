import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mit_ocw/features/course/data/watch_history_repository.dart';
import 'package:mit_ocw/features/course/domain/lecture.dart';
import 'package:mit_ocw/features/course/presentation/courses/course_lecture_list.dart';
import 'package:mit_ocw/features/course/presentation/courses/video_player.dart';
import 'package:mit_ocw/routes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:mit_ocw/config/ocw_config.dart';

class CourseLectureScreen extends StatefulWidget {
  final String coursenum;
  final List<Lecture> lectures;
  final int lectureNumber;

  const CourseLectureScreen({
    super.key,
    required this.coursenum,
    required this.lectures,
    required this.lectureNumber
  });

  @override
  _CourseLectureScreenState createState() => _CourseLectureScreenState();
}

class _CourseLectureScreenState extends State<CourseLectureScreen> {
  final Logger logger = Logger();
  final Dio _dio = Dio();

  String? _videoKey;
  Duration? _startPos;
  String? _errorMessage;

  String _getLectureKey() {
    final lecture = widget.lectures[widget.lectureNumber - 1];
    return lecture.key;
  }

  @override
  void initState() {
    super.initState();

    _setVideoKey();
  }

  @override
  void didUpdateWidget(covariant CourseLectureScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.lectureNumber != oldWidget.lectureNumber) {
      _setVideoKey();
    }
  }

  void updateWatchHistory(Duration position, Duration videoLength) {
    context.read<WatchHistoryRepository>().upsertWatchHistory(
      widget.coursenum,
      _getLectureKey(),
      widget.lectureNumber,
      position.inMilliseconds,
      videoLength.inMilliseconds
    );
  }

  Future<void> _setVideoKey() async {
    if (widget.lectures.isEmpty) {
      setState(() {
        _errorMessage = 'No lectures found for this course';
      });

      return;
    } else if (widget.lectureNumber < 1 || widget.lectureNumber > widget.lectures.length) {
      setState(() {
        _errorMessage = 'Lecture ${widget.lectureNumber} could not be found, please try again';
      });

      return;
    }

    logger.i("Setting video key for lecture $widget.lectureNumber");
    final lectureWebpageUrl = '$ocwUrl/${_getLectureKey()}';
    
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
                  final watchHistory = await context.read<WatchHistoryRepository>().getWatchHistory(widget.coursenum, _getLectureKey());

                  if (watchHistory != null) {
                    final watchPercent = watchHistory.position / watchHistory.lectureLength;

                    // If watched more than 98%, start from beginning
                    if (watchPercent < 0.98) {
                      setState(() {
                        _startPos = Duration(milliseconds: watchHistory.position);
                      });
                    } else {
                      setState(() {
                        _startPos = null;
                      });
                    }
                  }

                  setState(() {
                    _errorMessage = null;
                    _videoKey = videoId;
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
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          logger.i("Building landscape");
          return _buildLandscape();
        } else {
          logger.i("Building portrait");
          return _buildPortrait();
        }
      },
    );
  }

  Widget _buildLandscape() {
    return _buildVideoPlayer(
      fullscreen: true,
      builder: (context, player) {
        return player;
      }
    );
  }

  Widget _buildPortrait() {
    return _buildVideoPlayer(
      fullscreen: false,
      builder: (context, player) {
        return CustomScrollView(
          slivers: [
            PinnedHeaderSliver(
              child: player,
            ),
            CourseLectureList(
              onLectureSelected: (lecture, index) {
                logger.i("Selected lecture ${index + 1}");

                CourseLectureScreenRoute(
                  coursenum: lecture.coursenum,
                  lectureNumber: index + 1
                ).go(context);
              },
            )
          ],
        );
      }
    );
  }

  Widget _buildVideoPlayer({
    required bool fullscreen,
    required Widget Function(BuildContext, Widget) builder
  }) {
    if (_videoKey == null) {
      return Center(
        child: _errorMessage != null
            ? Text(_errorMessage!, style: const TextStyle(color: Colors.white))
            : const CircularProgressIndicator(),
      );
    }

    return VideoPlayer(
      videoKey: _videoKey!,
      startPos: _startPos,
      onPositionChanged: updateWatchHistory,
      fullscreen: fullscreen,
      builder: builder
    );
  }
}
