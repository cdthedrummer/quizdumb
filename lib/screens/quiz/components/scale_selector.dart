import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaleButton extends StatelessWidget {
  final int value;
  final int currentValue;
  final VoidCallback onTap;

  const ScaleButton({
    Key? key,
    required this.value,
    required this.currentValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == currentValue;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(
              color: isSelected ? Colors.purple : Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
        ),
      ),
    );
  }
}

class ScaleSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const ScaleSelector({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return ScaleButton(
              value: index + 1,
              currentValue: value,
              onTap: () => onChanged(index + 1),
            );
          }),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Not Really',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              'Love It!',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ],
    );
  }
}