import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isMultiSelect;
  final Function(Offset position) onSelect;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isMultiSelect,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) => onSelect(details.globalPosition),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.white.withAlpha(51) : Colors.black.withAlpha(26),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withAlpha(77),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              Icon(
                isMultiSelect
                    ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                    : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                color: Colors.white.withAlpha(230),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}