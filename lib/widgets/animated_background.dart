import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'shape_data.dart';

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
    _addShapes(5);
    
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_shapes.length < 15) {
        _addShapes(1);
      }
    });
  }

  void _addShapes(int count) {
    for (var i = 0; i < count; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: _random.nextInt(10) + 15),
        vsync: this,
      );

      final shapeType = ShapeType.values[_random.nextInt(ShapeType.values.length)];
      
      final shape = ShapeData(
        controller: controller,
        color: widget.colors[_random.nextInt(widget.colors.length)]
            .withAlpha((_random.nextDouble() * 155 + 100).toInt()),
        size: _random.nextDouble() * 40 + 20,
        position: Offset(
          _random.nextDouble() * MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height + 50,
        ),
        shape: shapeType,
      );

      final animation = Tween<Offset>(
        begin: shape.position,
        end: Offset(
          shape.position.dx + (_random.nextDouble() * 100 - 50),
          -50.0,
        ),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));

      animation.addListener(() {
        if (mounted) {
          setState(() {
            shape.position = animation.value;
          });
        }
      });

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            setState(() {
              _shapes.remove(shape);
              controller.dispose();
            });
          }
        }
      });

      setState(() {
        _shapes.add(shape);
      });
      controller.forward();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var shape in _shapes) {
      shape.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildShape(ShapeData shape) {
    switch (shape.shape) {
      case ShapeType.circle:
        return Container(
          width: shape.size,
          height: shape.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: shape.color,
          ),
        );
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(shape.size, shape.size),
          painter: TrianglePainter(color: shape.color),
        );
      case ShapeType.star:
        return CustomPaint(
          size: Size(shape.size, shape.size),
          painter: StarPainter(color: shape.color),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ...widget.colors.isEmpty 
          ? [] 
          : _shapes.map((shape) => Positioned(
              left: shape.position.dx,
              top: shape.position.dy,
              child: Transform.rotate(
                angle: shape.controller.value * 2 * math.pi,
                child: _buildShape(shape),
              ),
            )),
        widget.child,
      ],
    );
  }
}