import 'package:flutter/material.dart';
import '../models/question.dart';

class MultipleChoiceQuestion extends StatelessWidget {
  final Question question;
  final List<String> selectedOptions;
  final Function(List<String>) onChanged;

  const MultipleChoiceQuestion({
    Key? key,
    required this.question,
    required this.selectedOptions,
    required this.onChanged,
  }) : super(key: key);

  void _toggleOption(String option) {
    final newSelection = List<String>.from(selectedOptions);
    if (question.isMultipleChoice) {
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
    onChanged(newSelection);
  }

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
        if (question.isMultipleChoice)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Select all that apply:',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: 16),
        ...question.options!.map((option) {
          final isSelected = selectedOptions.contains(option);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Material(
              color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _toggleOption(option),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        question.isMultipleChoice
                            ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                            : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                        color: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          option,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: isSelected ? Colors.white : Colors.white70,
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
      ],
    );
  }
}
