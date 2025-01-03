import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'slider_trail.dart';

class ScaleSelector extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final Map<int, String>? labels;

  const ScaleSelector({
    Key? key,
    required this.value,
    required this.onChanged,
    this.labels,
  }) : super(key: key);

  @override
  State<ScaleSelector> createState() => _ScaleSelectorState();
}

class _ScaleSelectorState extends State<ScaleSelector> {
  bool _isDragging = false;
  Offset _dragPosition = Offset.zero;
  final GlobalKey _sliderKey = GlobalKey();

  void _updateDragPosition(double value) {
    if (_sliderKey.currentContext != null) {
      final RenderBox box = _sliderKey.currentContext!.findRenderObject() as RenderBox;
      final sliderWidth = box.size.width;
      final thumbPosition = (value - 1) / 6 * (sliderWidth - 32); // Accounting for thumb width
      setState(() {
        _dragPosition = Offset(thumbPosition + 16, box.size.height / 2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTrail(
          isDragging: _isDragging,
          position: _dragPosition,
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
              overlayColor: Colors.white10,
              trackHeight: 8.0,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 16.0,
                pressedElevation: 8.0,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Container(
              key: _sliderKey,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Slider(
                value: widget.value,
                min: 1.0,
                max: 7.0,
                divisions: 6,
                onChangeStart: (value) {
                  setState(() {
                    _isDragging = true;
                    _updateDragPosition(value);
                  });
                },
                onChanged: (newValue) {
                  HapticFeedback.lightImpact();
                  _updateDragPosition(newValue);
                  widget.onChanged(newValue);
                },
                onChangeEnd: (value) {
                  setState(() {
                    _isDragging = false;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.labels?[1] ?? 'Not Really',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              widget.labels?[7] ?? 'Love It!',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.labels?[widget.value.round()] ?? widget.value.round().toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
        ),
      ],
    );
  }
}