import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationButtons extends StatelessWidget {
  final bool isLastQuestion;
  final bool hasAnswers;
  final bool canGoBack;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const NavigationButtons({
    Key? key,
    required this.isLastQuestion,
    required this.hasAnswers,
    this.canGoBack = false,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (canGoBack)
            TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.white70),
              label: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Quicksand',
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          
          if (hasAnswers)
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                isLastQuestion ? 'Finish' : 'Next',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
        ],
      ),
    );
  }
}