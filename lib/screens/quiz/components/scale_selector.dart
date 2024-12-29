import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              final currentValue = index + 1;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onChanged(currentValue);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: value == currentValue
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: value == currentValue ? 3 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      currentValue.toString(),
                      style: TextStyle(
                        color: value == currentValue
                            ? Colors.purple
                            : Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ),
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
      ),
    );
  }
}