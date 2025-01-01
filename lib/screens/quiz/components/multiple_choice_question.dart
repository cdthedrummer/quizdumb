import 'package:flutter/material.dart';

class MultipleChoiceQuestion extends StatelessWidget {
  final List<String> options;
  final bool isMultiSelect;
  final List<String> selectedAnswers;
  final Function(List<String>) onAnswerSelected;

  const MultipleChoiceQuestion({
    super.key,
    required this.options,
    required this.isMultiSelect,
    required this.selectedAnswers,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedAnswers.contains(option);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handleOptionTap(option),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                    width: 2,
                  ),
                  color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
                ),
                child: Row(
                  children: [
                    if (isMultiSelect)
                      Checkbox(
                        value: isSelected,
                        onChanged: (_) => _handleOptionTap(option),
                      )
                    else
                      Radio<bool>(
                        value: true,
                        groupValue: isSelected,
                        onChanged: (_) => _handleOptionTap(option),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isSelected ? Theme.of(context).primaryColor : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleOptionTap(String option) {
    if (isMultiSelect) {
      final newAnswers = List<String>.from(selectedAnswers);
      if (selectedAnswers.contains(option)) {
        newAnswers.remove(option);
      } else {
        newAnswers.add(option);
      }
      onAnswerSelected(newAnswers);
    } else {
      onAnswerSelected([option]);
    }
  }
}