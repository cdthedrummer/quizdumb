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
        // Previous Button
        TextButton.icon(
          onPressed: onPrevious,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
          style: TextButton.styleFrom(
            foregroundColor: onPrevious == null 
              ? Colors.grey 
              : Theme.of(context).primaryColor,
          ),
        ),
        // Next Button
        ElevatedButton.icon(
          onPressed: showNext ? onNext : null,
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Next'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}