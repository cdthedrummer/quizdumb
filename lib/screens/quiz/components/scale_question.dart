import 'package:flutter/material.dart';

class ScaleQuestion extends StatelessWidget {
  final Map<int, String> labels;
  final int value;
  final ValueChanged<int> onChanged;

  const ScaleQuestion({
    super.key,
    required this.labels,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          labels[value] ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 32),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Theme.of(context).primaryColor,
            inactiveTrackColor: Theme.of(context).primaryColor.withOpacity(0.2),
            thumbColor: Theme.of(context).primaryColor,
            overlayColor: Theme.of(context).primaryColor.withOpacity(0.1),
            valueIndicatorColor: Theme.of(context).primaryColor,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Slider(
            min: 1,
            max: 7,
            divisions: 6,
            value: value.toDouble(),
            label: value.toString(),
            onChanged: (newValue) => onChanged(newValue.round()),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labels[1] ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              labels[7] ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}