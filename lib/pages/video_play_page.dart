import 'package:flutter/material.dart';

import '../components/youtube_player_widget.dart';

class VideoPlayPage extends StatelessWidget {
  final String videoId;

  VideoPlayPage({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ここに動画再生に関するUIを記述
    return Scaffold(
      appBar: AppBar(
        title: Text('動画再生'),
      ),
      body: Container(child: YoutubePlayerWidget(videoId: videoId)),
    );
  }
}
