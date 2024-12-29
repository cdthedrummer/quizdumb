import 'package:flutter/material.dart';

class QuizProgressBar extends StatelessWidget {
  final double progress;

  const QuizProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white.withAlpha(26),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white.withAlpha(179),
          ),
        ),
      ),
    );
  }
}