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
    const textStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Quicksand',
      fontSize: 16,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          labels[value] ?? '',
          style: textStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.white.withAlpha(230),
            inactiveTrackColor: Colors.white.withAlpha(50),
            thumbColor: Colors.white,
            overlayColor: Colors.white.withAlpha(30),
            valueIndicatorColor: Colors.white.withAlpha(230),
            valueIndicatorTextStyle: textStyle.copyWith(
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
              style: textStyle.copyWith(
                fontSize: 14,
                color: Colors.white.withAlpha(180),
              ),
            ),
            Text(
              labels[7] ?? '',
              style: textStyle.copyWith(
                fontSize: 14,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ],
    );
  }
}