import 'package:flutter/material.dart';
import '../../../models/question.dart';

class ScaleQuestion extends StatelessWidget {
  final Question question;
  final Function(double) onChanged;
  final double currentValue;

  const ScaleQuestion({
    Key? key,
    required this.question,
    required this.onChanged,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question.text,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    question.getScaleLabel(1),
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    question.getScaleLabel(7),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SliderTheme(
                data: theme.sliderTheme,
                child: Slider(
                  value: currentValue,
                  min: 1.0,
                  max: 7.0,
                  divisions: 6,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              question.getScaleLabel(currentValue.round()),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
