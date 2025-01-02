import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final String? emoji;

  const QuizOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withAlpha(100)
              : Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected
                ? Colors.white.withAlpha(200)
                : Colors.white.withAlpha(50),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            if (emoji != null) ...[
              Text(
                emoji!,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                text,
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
    );
  }
}