import 'package:flutter/material.dart';
import 'slider_trail.dart';

class ScaleQuestion extends StatefulWidget {
  final Map<int, String> labels;
  final int value;
  final ValueChanged<int> onChanged;
  final AnimationController? backgroundController;

  const ScaleQuestion({
    super.key,
    required this.labels,
    required this.value,
    required this.onChanged,
    this.backgroundController,
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

  void _updateSliderPosition() {
    final RenderBox? renderBox = _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final sliderWidth = renderBox.size.width - 16; // Account for thumb radius
      final position = (widget.value - 1) / 6; // Normalize to 0-1
      final xPosition = (sliderWidth * position) + 8; // Add back thumb radius
      
      setState(() {
        _sliderPosition = Offset(xPosition, renderBox.size.height / 2);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Pause background animation
    widget.backgroundController?.stop();
  }

  @override
  void dispose() {
    // Resume background animation
    widget.backgroundController?.repeat();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScaleQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _updateSliderPosition();
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
        LayoutBuilder(
          builder: (context, constraints) {
            return SliderTrail(
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
                  key: _sliderKey,
                  min: 1,
                  max: 7,
                  divisions: 6,
                  value: widget.value.toDouble(),
                  label: widget.value.toString(),
                  onChangeStart: (value) {
                    setState(() => _isDragging = true);
                    _updateSliderPosition();
                  },
                  onChanged: (newValue) {
                    widget.onChanged(newValue.round());
                    _updateSliderPosition();
                  },
                  onChangeEnd: (value) {
                    setState(() => _isDragging = false);
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
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