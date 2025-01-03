import 'dart:math';
import 'package:flutter/material.dart';

class SuccessBurst extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final Offset? burstPoint; // Add point to emit from

  const SuccessBurst({
    Key? key,
    required this.child,
    required this.trigger,
    this.burstPoint,
  }) : super(key: key);

  @override
  State<SuccessBurst> createState() => _SuccessBurstState();
}

class _SuccessBurstState extends State<SuccessBurst> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<BurstParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _createParticles(Offset center) {
    _particles.clear();
    
    // Create multiple small particles
    for (int i = 0; i < 12; i++) {
      // Calculate angle spread (-30 to +30 degrees from vertical)
      double angle = -pi/2 + (pi/6 * _random.nextDouble() - pi/12);
      double speed = 2 + _random.nextDouble() * 2;
      
      _particles.add(BurstParticle(
        position: center,
        velocity: Offset(
          cos(angle) * speed,
          sin(angle) * speed,
        ),
        size: 2 + _random.nextDouble() * 3,
        color: Colors.white.withAlpha((_random.nextDouble() * 50 + 30).toInt()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_controller.isAnimating)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: BurstPainter(
                  particles: _particles,
                  progress: _controller.value,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void didUpdateWidget(SuccessBurst oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger && widget.burstPoint != null) {
      _createParticles(widget.burstPoint!);
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BurstParticle {
  Offset position;
  final Offset velocity;
  final double size;
  final Color color;

  BurstParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
  });

  void update(double progress) {
    position += velocity;
  }
}

class BurstPainter extends CustomPainter {
  final List<BurstParticle> particles;
  final double progress;

  BurstPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      particle.update(progress);
      
      final paint = Paint()
        ..color = particle.color.withAlpha(((1 - progress) * 255).toInt())
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(BurstPainter oldDelegate) => true;
}