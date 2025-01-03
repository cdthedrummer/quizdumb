import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  late final AnimationController _controller;
  final List<BackgroundShape> _shapes = [];
  static const int numberOfShapes = 15;

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
            300 + random.nextDouble() * 300, // Start from middle of screen
          ),
          size: 2 + random.nextDouble() * 5, // Much smaller particles
          speed: 0.3 + random.nextDouble() * 0.5, // Slower movement
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.colors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: BackgroundPainter(
                shapes: _shapes,
                animation: _controller,
              ),
              isComplex: true,
              willChange: true,
            ),
          ),
          IgnorePointer(
            child: CustomPaint(
              painter: BackgroundPainter(
                shapes: _shapes,
                animation: _controller,
              ),
              isComplex: true,
              willChange: true,
            ),
          ),
          widget.child,
        ],
      ),
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
      ..color = Colors.white.withAlpha(10) // More transparent
      ..style = PaintingStyle.fill;

    for (var shape in shapes) {
      final movement = Offset(
        math.cos(shape.angle) * shape.speed * animation.value,
        math.sin(shape.angle) * shape.speed * animation.value - 0.3,
      );
      
      shape.position += movement;

      if (shape.position.dy < -shape.size) {
        shape.position = Offset(
          shape.position.dx,
          size.height + shape.size,
        );
      }

      canvas.drawCircle(shape.position, shape.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}