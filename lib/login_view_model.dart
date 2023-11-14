import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_data.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginData>((ref) {
  return LoginViewModel();
});

class LoginViewModel extends StateNotifier<LoginData> {
  LoginViewModel() : super(LoginData());

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  // ログイン成功時のコールバック
  VoidCallback? onLoginSuccess;

  Future<void> login() async {
    try {
      // ログインロジック...
      // ログイン成功時のアクションを実行
      onLoginSuccess?.call();
    } catch (e) {
      // エラーハンドリング...
    }
  }
}
