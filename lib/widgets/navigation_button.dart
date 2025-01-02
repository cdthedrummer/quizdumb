import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const NavigationButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? Colors.white.withAlpha(230)
            : Colors.white.withAlpha(30),
        foregroundColor: isPrimary
            ? Theme.of(context).primaryColor
            : Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.white.withAlpha(isPrimary ? 230 : 50),
          ),
        ),
        elevation: isPrimary ? 2 : 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Quicksand',
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}