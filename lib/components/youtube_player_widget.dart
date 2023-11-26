import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerWidget extends StatelessWidget {
  final String videoId;

  YoutubePlayerWidget({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Column(
          children: [
            player,
            Text('Youtube Player'),
          ],
        );
      },
    );

    // return YoutubePlayer(controller: _controller, aspectRatio: 16 / 9);
  }
}
