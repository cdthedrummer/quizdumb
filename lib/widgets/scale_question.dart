import 'package:flutter/material.dart';
import '../models/question.dart';

class ScaleQuestion extends StatefulWidget {
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
  State<ScaleQuestion> createState() => _ScaleQuestionState();
}

class _ScaleQuestionState extends State<ScaleQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.question.text,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Text(
                widget.question.getScaleLabel(1),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.purple,
                    inactiveTrackColor: Colors.purple.withOpacity(0.2),
                    thumbColor: Colors.purple,
                    overlayColor: Colors.purple.withOpacity(0.1),
                    trackHeight: 4.0,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
                  ),
                  child: Slider(
                    value: widget.currentValue,
                    min: 1.0,
                    max: 7.0,
                    divisions: 6,
                    onChanged: widget.onChanged,
                  ),
                ),
              ),
              Text(
                widget.question.getScaleLabel(7),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.question.getScaleLabel(widget.currentValue.round()),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
