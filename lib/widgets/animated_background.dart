import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;

  const AnimatedBackground({
    Key? key,
    required this.child,
    required this.colors,
  }) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  final List<ShapeData> _shapes = [];
  Timer? _timer;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    // Create initial shapes
    _addShapes(5);
    
    // Periodically add new shapes
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_shapes.length < 15) {
        _addShapes(1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var shape in _shapes) {
      shape.controller.dispose();
    }
    super.dispose();
  }
  
  // ... rest of your existing code ...
}