import 'package:flutter/material.dart';
import '../models/question.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final Question question;
  final List<String> selectedOptions;
  final Function(List<String>) onChanged;

  const MultipleChoiceQuestion({
    Key? key,
    required this.question,
    required this.selectedOptions,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  void _toggleOption(String option) {
    final newSelection = List<String>.from(widget.selectedOptions);
    if (widget.question.isMultipleChoice) {
      if (newSelection.contains(option)) {
        newSelection.remove(option);
      } else {
        newSelection.add(option);
      }
    } else {
      newSelection
        ..clear()
        ..add(option);
    }
    widget.onChanged(newSelection);
  }

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
        if (widget.question.isMultipleChoice)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Select all that apply:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: 16),
        ...widget.question.options!.map((option) {
          final isSelected = widget.selectedOptions.contains(option);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Material(
              color: isSelected ? Colors.purple.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _toggleOption(option),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        widget.question.isMultipleChoice
                            ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                            : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: isSelected ? Colors.purple : Colors.black87,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        if (widget.question.isMultipleChoice && widget.selectedOptions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Trigger next question
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
