import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;

  const AnimatedBackground({
    super.key,
    required this.child,
    required this.colors,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  final List<ShapeData> _shapes = [];
  late Timer _timer;
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
    _timer.cancel();
    for (var shape in _shapes) {
      shape.controller.dispose();
    }
    super.dispose();
  }

  void _addShapes(int count) {
    for (var i = 0; i < count; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: _random.nextInt(10) + 15),
        vsync: this,
      );

      final shape = ShapeData(
        controller: controller,
        color: widget.colors[_random.nextInt(widget.colors.length)]
            .withOpacity(0.1),
        size: _random.nextDouble() * 40 + 20,
        position: Offset(
          _random.nextDouble() * MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height + 50,
        ),
        shape: _random.nextBool() ? ShapeType.circle : ShapeType.triangle,
      );

      final animation = Tween<Offset>(
        begin: shape.position,
        end: Offset(
          shape.position.dx + (_random.nextDouble() * 100 - 50),
          -50.0,
        ),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ));

      animation.addListener(() {
        shape.position = animation.value;
        if (mounted) setState(() {});
      });

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shapes.remove(shape);
          shape.controller.dispose();
          if (mounted) setState(() {});
        }
      });

      _shapes.add(shape);
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated shapes
        ..._shapes.map((shape) => Positioned(
          left: shape.position.dx,
          top: shape.position.dy,
          child: Transform.rotate(
            angle: shape.controller.value * 2 * math.pi,
            child: _buildShape(shape),
          ),
        )),
        // Main content
        widget.child,
      ],
    );
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
    }
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => color != oldDelegate.color;
}

enum ShapeType { circle, triangle }

class ShapeData {
  final AnimationController controller;
  final Color color;
  final double size;
  Offset position;
  final ShapeType shape;

  ShapeData({
    required this.controller,
    required this.color,
    required this.size,
    required this.position,
    required this.shape,
  });
}