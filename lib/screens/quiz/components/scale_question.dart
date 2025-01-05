import 'package:flutter/material.dart';
import 'slider_trail.dart';

class ScaleQuestion extends StatefulWidget {
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
  State<ScaleQuestion> createState() => _ScaleQuestionState();
}

class _ScaleQuestionState extends State<ScaleQuestion> {
  bool _isDragging = false;
  Offset _sliderPosition = Offset.zero;
  final GlobalKey _sliderKey = GlobalKey();

  String _getLabelForValue(int value) {
    if (value <= 2) return widget.labels[1] ?? '';
    if (value >= 6) return widget.labels[7] ?? '';
    return widget.labels[4] ?? '';
  }

  void _calculateSliderPosition() {
    final RenderBox? renderBox = _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final sliderWidth = renderBox.size.width;
    final normalizedValue = (widget.value - 1) / 6; // Convert to 0-1 range
    final xPos = 16 + (sliderWidth - 32) * normalizedValue; // Account for padding

    setState(() {
      _sliderPosition = Offset(xPos, renderBox.size.height / 2);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSliderPosition();
    });
  }

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
        // Current value label with animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            _getLabelForValue(widget.value),
            key: ValueKey<int>(widget.value),
            style: textStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Slider with trail effect
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              key: _sliderKey,
              width: constraints.maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SliderTrail(
                isDragging: _isDragging,
                position: _sliderPosition,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(0.9),
                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withOpacity(0.12),
                    valueIndicatorColor: Colors.white.withOpacity(0.9),
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
                    activeTickMarkColor: Colors.white.withOpacity(0.9),
                    inactiveTickMarkColor: Colors.white.withOpacity(0.4),
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
                      _calculateSliderPosition();
                    },
                    onChangeEnd: (value) {
                      setState(() => _isDragging = false);
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        // Min and max labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.labels[1] ?? '',
              style: textStyle.copyWith(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            Text(
              widget.labels[7] ?? '',
              style: textStyle.copyWith(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}