import 'package:flutter/material.dart';
import '../../../models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Animation<double> fadeAnimation;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.fadeAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeTransition(
          opacity: fadeAnimation,
          child: Text(
            question.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (question.isMultipleChoice)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Select all that apply',
              style: TextStyle(
                color: Colors.white.withAlpha(204),
                fontStyle: FontStyle.italic,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
      ],
    );
  }
}