import 'package:flutter/material.dart';
import '../../models/result.dart';
import '../../screens/results/results_screen.dart';

class NavigationHandler {
  static void showResults(BuildContext context, QuizResult quizResult) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(),
      ),
    );
  }

  static Duration getTransitionDuration() => const Duration(milliseconds: 500);

  static bool shouldAutoAdvance(bool isSingleChoice) => isSingleChoice;
}