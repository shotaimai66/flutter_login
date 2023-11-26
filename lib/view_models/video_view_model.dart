// video_view_model.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class VideoViewModel {
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

  Future<List<dynamic>> fetchVideos() async {
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
        return items;
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
}
