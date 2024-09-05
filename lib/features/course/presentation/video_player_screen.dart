import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:mit_ocw/config/ocw_config.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String lectureKey;

  const VideoPlayerScreen({Key? key, required this.lectureKey}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _youtubePlayerController;
  final Dio _dio = Dio();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
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
                setState(() {
                  _youtubePlayerController = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  );
                });
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
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play Video"),
      ),
      body: Center(
        child: _youtubePlayerController != null
            ? YoutubePlayer(
                controller: _youtubePlayerController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              )
            : _errorMessage != null
                ? Text(_errorMessage!)
                : const CircularProgressIndicator(),
      ),
    );
  }
}