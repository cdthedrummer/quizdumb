import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(200),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${(progress * 100).toInt()}% Complete',
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 14,
            fontFamily: 'Quicksand',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}