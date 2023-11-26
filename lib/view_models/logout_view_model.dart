import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class LogoutViewModel {
  void logout(BuildContext context) async {
    try {
      await Amplify.Auth.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print('ログアウトエラー: $e');
    }
  }
}
