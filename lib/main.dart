import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: LoginPage(),
        theme: _buildTheme(Brightness.dark),
      ),
    ),
  );
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}
