import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/resolver.dart';

import 'amplifyconfiguration.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyconfig);
    print('Successfully configured');
  } on Exception catch (e) {
    print('Error configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      stringResolver: stringResolver,
      child: MaterialApp(
        builder: Authenticator.builder(),
        theme: ThemeData.dark(),
        home: Authenticator(
          child: HomePage(), // ログイン成功後に表示されるページ
        ),
      ),
    );
  }
}
