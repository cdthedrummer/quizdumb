import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/question.dart';

class AnswerOptions extends StatelessWidget {
  final Question question;
  final List<String> selectedAnswers;
  final Function(String) onOptionSelected;

  const AnswerOptions({
    Key? key,
    required this.question,
    required this.selectedAnswers,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (question.options == null || question.options!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (question.type == 'multiple')
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Select all that apply',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: question.options!.length,
            itemBuilder: (context, index) {
              final option = question.options![index];
              final isSelected = selectedAnswers.contains(option);
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onOptionSelected(option);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Colors.white.withOpacity(0.9)
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            question.type == 'multiple'
                                ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                                : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                            color: isSelected ? Colors.purple : Colors.white,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                color: isSelected ? Colors.purple : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Quicksand',
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
          ),
        ),
      ],
    );
  }
}
