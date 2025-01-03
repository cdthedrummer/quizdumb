import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  
  const AnimatedBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<BackgroundShape> _shapes = [];
  static const int numberOfShapes = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _initializeShapes();
  }

  void _initializeShapes() {
    final random = math.Random();
    for (int i = 0; i < numberOfShapes; i++) {
      _shapes.add(
        BackgroundShape(
          position: Offset(
            random.nextDouble() * 300,
            random.nextDouble() * 600,
          ),
          size: 20 + random.nextDouble() * 30,
          speed: 1 + random.nextDouble() * 2,
          angle: random.nextDouble() * 2 * math.pi,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: BackgroundPainter(
            shapes: _shapes,
            animation: _controller,
          ),
          size: Size.infinite,
        ),
        widget.child,
      ],
    );
  }
}

class BackgroundShape {
  Offset position;
  final double size;
  final double speed;
  final double angle;

  BackgroundShape({
    required this.position,
    required this.size,
    required this.speed,
    required this.angle,
  });
}

class BackgroundPainter extends CustomPainter {
  final List<BackgroundShape> shapes;
  final Animation<double> animation;

  BackgroundPainter({
    required this.shapes,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (var shape in shapes) {
      // Update position
      final movement = Offset(
        math.cos(shape.angle) * shape.speed * animation.value,
        math.sin(shape.angle) * shape.speed * animation.value - 1, // Drift upward
      );
      
      shape.position += movement;

      // Reset position if out of bounds
      if (shape.position.dy < -shape.size) {
        shape.position = Offset(
          shape.position.dx,
          size.height + shape.size,
        );
      }

      // Draw shape
      canvas.drawCircle(shape.position, shape.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}