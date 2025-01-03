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

  void _handleDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragPosition = details.localPosition;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition = details.localPosition;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
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
        Text(
          widget.labels[widget.value] ?? '',
          style: textStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32),
        SliderTrail(
          isDragging: _isDragging,
          position: _dragPosition,
          child: GestureDetector(
            onHorizontalDragStart: _handleDragStart,
            onHorizontalDragUpdate: _handleDragUpdate,
            onHorizontalDragEnd: _handleDragEnd,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white.withAlpha(230),
                inactiveTrackColor: Colors.white.withAlpha(50),
                thumbColor: Colors.white,
                overlayColor: Colors.white.withAlpha(30),
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
                inactiveTickMarkColor: Colors.white.withAlpha(100),
              ),
              child: Slider(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.labels[1] ?? '',
              style: textStyle.copyWith(
                fontSize: 14,
                color: Colors.white.withAlpha(180),
              ),
            ),
            Text(
              widget.labels[7] ?? '',
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