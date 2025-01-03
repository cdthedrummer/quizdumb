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
  Offset _dragPosition = Offset.zero;
  final GlobalKey _sliderKey = GlobalKey();

  String _getLabelForValue(int value) {
    if (value <= 2) return widget.labels[1] ?? '';
    if (value >= 6) return widget.labels[7] ?? '';
    return widget.labels[4] ?? '';
  }

  void _updateDragPosition(Offset globalPosition) {
    final RenderBox? renderBox = _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _dragPosition = renderBox.globalToLocal(globalPosition);
      });
    }
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
        // Current value label
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
        SliderTrail(
          isDragging: _isDragging,
          position: _dragPosition,
          child: Listener(
            onPointerDown: (event) {
              setState(() => _isDragging = true);
              _updateDragPosition(event.position);
            },
            onPointerMove: (event) {
              _updateDragPosition(event.position);
            },
            onPointerUp: (event) {
              setState(() => _isDragging = false);
            },
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
                key: _sliderKey,
                min: 1,
                max: 7,
                divisions: 6,
                value: widget.value.toDouble(),
                label: widget.value.toString(),
                onChanged: (newValue) => widget.onChanged(newValue.round()),
              ),
            ),
          ),
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