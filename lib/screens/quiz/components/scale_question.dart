import 'package:flutter/material.dart';
import 'slider_trail.dart';

class ScaleQuestion extends StatefulWidget {
  final Map<int, String> labels;
  final int value;
  final ValueChanged<int> onChanged;
  final VoidCallback? onInteractionEnd;

  const ScaleQuestion({
    super.key,
    required this.labels,
    required this.value,
    required this.onChanged,
    this.onInteractionEnd,
  });

  @override
  State<ScaleQuestion> createState() => _ScaleQuestionState();
}

class _ScaleQuestionState extends State<ScaleQuestion> {
  bool _isDragging = false;
  Offset? _sliderPosition;

  String _getLabelForValue(int value) {
    if (value <= 2) return widget.labels[1] ?? '';
    if (value >= 6) return widget.labels[7] ?? '';
    return widget.labels[4] ?? '';
  }

  Offset _getSliderPosition(double width) {
    final normalizedValue = (widget.value - 1) / 6;
    final xPos = 16 + (width - 32) * normalizedValue;
    return Offset(xPos, 24);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Quicksand',
      fontSize: 16,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final position = _sliderPosition ?? _getSliderPosition(constraints.maxWidth);
        _sliderPosition = position;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 28,
              alignment: Alignment.center,
              child: Text(
                _getLabelForValue(widget.value),
                style: textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: constraints.maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SliderTrail(
                isDragging: _isDragging,
                position: position,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withAlpha(230),
                    inactiveTrackColor: Colors.white.withAlpha(51),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withAlpha(31),
                    valueIndicatorColor: Colors.white.withAlpha(230),
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                    ),
                    trackHeight: 4.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8.0,
                      elevation: 4.0,
                    ),
                    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 4),
                    activeTickMarkColor: Colors.white.withAlpha(230),
                    inactiveTickMarkColor: Colors.white.withAlpha(102),
                  ),
                  child: Slider(
                    min: 1,
                    max: 7,
                    divisions: 6,
                    value: widget.value.toDouble(),
                    label: widget.value.toString(),
                    onChangeStart: (value) {
                      setState(() => _isDragging = true);
                    },
                    onChanged: (newValue) {
                      widget.onChanged(newValue.round());
                      setState(() {
                        _sliderPosition = _getSliderPosition(constraints.maxWidth);
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() => _isDragging = false);
                      widget.onInteractionEnd?.call();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.labels[1] ?? '',
                    style: textStyle.copyWith(
                      fontSize: 14,
                      color: Colors.white.withAlpha(179),
                    ),
                  ),
                  Text(
                    widget.labels[7] ?? '',
                    style: textStyle.copyWith(
                      fontSize: 14,
                      color: Colors.white.withAlpha(179),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}