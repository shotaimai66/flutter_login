import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_view_model.dart';
import 'next_page.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final loginData = ref.watch(loginViewModelProvider);

    // ログイン成功時のナビゲーション
    viewModel.onLoginSuccess = () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NextPage()),
      );
    };

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => viewModel.setUsername(value),
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              onChanged: (value) => viewModel.setPassword(value),
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () => viewModel.login(),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
