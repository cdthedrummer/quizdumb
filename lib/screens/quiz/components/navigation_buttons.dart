import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback onNext;
  final bool showNext;

  const NavigationButtons({
    super.key,
    this.onPrevious,
    required this.onNext,
    required this.showNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onPrevious,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white.withAlpha(30),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                size: 18,
                color: Colors.white.withAlpha(onPrevious == null ? 100 : 255),
              ),
              const SizedBox(width: 8),
              Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white.withAlpha(onPrevious == null ? 100 : 255),
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: showNext ? onNext : null,
          style: TextButton.styleFrom(
            backgroundColor: showNext ? Colors.white : Colors.white.withAlpha(30),
            foregroundColor: showNext ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Next',
                style: TextStyle(
                  color: showNext 
                      ? Theme.of(context).primaryColor 
                      : Colors.white.withAlpha(100),
                  fontWeight: showNext ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Quicksand',
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 18,
                color: showNext 
                    ? Theme.of(context).primaryColor 
                    : Colors.white.withAlpha(100),
              ),
            ],
          ),
        ),
      ],
    );
  }
}