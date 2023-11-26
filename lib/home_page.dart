import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _logout(BuildContext context) async {
    try {
      await Amplify.Auth.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print('ログアウトエラー: $e');
    }
  }

  Future<String> getIdToken() async {
    try {
      final session = await Amplify.Auth.getPlugin(
        AmplifyAuthCognito.pluginKey,
      ).fetchAuthSession() as CognitoAuthSession;

      final idToken = session.userPoolTokensResult.value?.idToken.raw;
      if (idToken != null) {
        print('IdToken: $idToken');
        return idToken;
      } else {
        throw Exception('IdToken is null');
      }
    } catch (e) {
      throw Exception('Error fetching IdToken: $e');
    }
  }

  Future<List<String>> fetchVideos() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://kt05s5oqi3.execute-api.ap-northeast-1.amazonaws.com/prd/videos'),
        headers: {
          'Authorization': await getIdToken(),
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final items = jsonResponse['items'] as List;
        List<String> videoUrls =
            items.map((element) => element['url'].toString()).toList();
        return videoUrls;
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ホームページ'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // ログアウトの処理を記述
              },
            ),
            IconButton(
              icon: Icon(Icons.video_library),
              onPressed: () {
                // ビデオを取得する処理を記述
              },
            ),
          ],
        ),
        body: YoutubePlayerWidget());
  }
}

class YoutubePlayerWidget extends StatelessWidget {
  // final String videoId;

  YoutubePlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = YoutubePlayerController.fromVideoId(
      videoId: 'jsJOU-TNftg',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
