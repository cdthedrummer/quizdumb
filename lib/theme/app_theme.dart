import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontFamily: 'Quicksand',
        ),
      ),
    );
  }
}