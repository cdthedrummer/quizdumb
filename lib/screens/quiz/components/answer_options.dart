import 'package:flutter/material.dart';
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
    // Early return if no options available
    if (question.options == null || question.options!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: question.options!.length,
      itemBuilder: (context, index) {
        final option = question.options![index];
        final isSelected = selectedAnswers.contains(option);
        
        return AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(
            bottom: 12.0,
            left: isSelected ? 8.0 : 0.0,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: () => onOptionSelected(option),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected 
                    ? Colors.white.withAlpha(230)
                    : Colors.white.withAlpha(51),
                foregroundColor: isSelected ? Colors.purple : Colors.white,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}