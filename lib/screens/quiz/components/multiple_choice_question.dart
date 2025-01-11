import 'package:flutter/material.dart';

class MultipleChoiceQuestion extends StatelessWidget {
  final List<String> options;
  final List<String> selectedAnswers;
  final bool isMultiSelect;
  final void Function(List<String>, Offset?) onAnswerSelected;

  const MultipleChoiceQuestion({
    super.key,
    required this.options,
    required this.selectedAnswers,
    required this.isMultiSelect,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isMultiSelect)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Select all that apply',
              style: TextStyle(
                color: Colors.white.withAlpha(200),
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontFamily: 'Quicksand',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ...options.map((option) {
          final isSelected = selectedAnswers.contains(option);
          return _buildOption(context, option, isSelected);
        }).toList(),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String option, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTapDown: (details) {
            if (isMultiSelect) {
              final newSelection = List<String>.from(selectedAnswers);
              if (selectedAnswers.contains(option)) {
                newSelection.remove(option);
              } else {
                newSelection.add(option);
              }
              onAnswerSelected(newSelection, details.globalPosition);
            } else {
              onAnswerSelected([option], details.globalPosition);
            }
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Colors.white.withAlpha(100)
                  : Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isSelected 
                    ? Colors.white
                    : Colors.white.withAlpha(50),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: Colors.white.withAlpha(isSelected ? 255 : 200),
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}