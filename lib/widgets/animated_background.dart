import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final bool isEnabled;
  
  const AnimatedBackground({
    Key? key,
    required this.child,
    required this.colors,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<BackgroundShape> _shapes = [];
  static const int numberOfShapes = 25; // More shapes

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Slower animation
    )..repeat();

    _initializeShapes();
  }

  void _initializeShapes() {
    final random = math.Random();
    for (int i = 0; i < numberOfShapes; i++) {
      _shapes.add(
        BackgroundShape(
          position: Offset(
            random.nextDouble() * 400,
            400 + random.nextDouble() * 400,
          ),
          size: 1.5 + random.nextDouble() * 2.5, // Much smaller (1.5-4px)
          speed: 0.2 + random.nextDouble() * 0.3, // Even slower movement
          angle: random.nextDouble() * 2 * math.pi,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(AnimatedBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled != oldWidget.isEnabled) {
      if (widget.isEnabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
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
          if (widget.isEnabled) ...[
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
          ],
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
      ..color = Colors.white.withOpacity(0.04) // More transparent
      ..style = PaintingStyle.fill;

    for (var shape in shapes) {
      final movement = Offset(
        math.cos(shape.angle) * shape.speed * animation.value,
        math.sin(shape.angle) * shape.speed * animation.value - 0.2,
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