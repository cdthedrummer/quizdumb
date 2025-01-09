import 'package:flutter/material.dart';
import '../../../models/question.dart';

class QuestionCardBase extends StatelessWidget {
  final Question question;
  final Widget child;

  const QuestionCardBase({
    super.key,
    required this.question,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question.text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Quicksand',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Expanded(child: child),
      ],
    );
  }
}