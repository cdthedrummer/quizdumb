import 'package:flutter/material.dart';
import 'quiz_option.dart';

class MultipleChoiceQuestion extends StatelessWidget {
  final List<String> options;
  final List<String> selectedAnswers;
  final bool isMultiSelect;
  final Function(List<String>) onAnswerSelected;

  const MultipleChoiceQuestion({
    super.key,
    required this.options,
    required this.selectedAnswers,
    required this.isMultiSelect,
    required this.onAnswerSelected,
  });

  void _handleOptionTap(String option) {
    if (isMultiSelect) {
      final newSelection = List<String>.from(selectedAnswers);
      if (selectedAnswers.contains(option)) {
        newSelection.remove(option);
      } else {
        newSelection.add(option);
      }
      onAnswerSelected(newSelection);
    } else {
      onAnswerSelected([option]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedAnswers.contains(option);
        
        return QuizOption(
          text: option,
          isSelected: isSelected,
          onTap: () => _handleOptionTap(option),
        );
      },
    );
  }
}