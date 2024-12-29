import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationButtons extends StatelessWidget {
  final bool isLastQuestion;
  final bool hasAnswers;
  final VoidCallback onNext;

  const NavigationButtons({
    Key? key,
    required this.isLastQuestion,
    required this.hasAnswers,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: hasAnswers ? 1.0 : 0.7,
      child: ElevatedButton(
        onPressed: hasAnswers ? () {
          HapticFeedback.mediumImpact();
          onNext();
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withAlpha(230),
          foregroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          isLastQuestion ? 'See Results' : 'Next',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
      ),
    );
  }
}