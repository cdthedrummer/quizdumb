import 'dart:math' as math;
import 'package:flutter/material.dart';

class SuccessBurst extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final Offset? burstPoint;

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
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
  }

  void _createParticles(Offset center) {
    setState(() {
      _particles.clear();
      
      // Create more particles with fountain effect
      for (int i = 0; i < 50; i++) {
        // Calculate angle for upward fountain (-110° to -70°)
        double angle = -math.pi * (0.39 + _random.nextDouble() * 0.22);
        
        // Vary initial velocities
        double speed = 1 + _random.nextDouble() * 2;
        
        _particles.add(BurstParticle(
          position: center,
          velocity: Offset(
            math.cos(angle) * speed,
            math.sin(angle) * speed,
          ),
          acceleration: const Offset(0, 0.15), // More gravity
          size: 1.5 + _random.nextDouble(), // Consistent size
          alpha: (_random.nextDouble() * 40 + 40).toInt(), // Higher base alpha
          rotationSpeed: (_random.nextDouble() - 0.5) * 0.2,
          maxAge: 0.8 + _random.nextDouble() * 0.4,
        ));
      }
    });
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
  Offset velocity;
  final Offset acceleration;
  final double size;
  final int alpha;
  final double rotationSpeed;
  final double maxAge;
  double age = 0;
  double rotation = 0;

  BurstParticle({
    required this.position,
    required this.velocity,
    required this.acceleration,
    required this.size,
    required this.alpha,
    required this.rotationSpeed,
    required this.maxAge,
  });

  void update(double progress) {
    velocity += acceleration;
    position += velocity;
    rotation += rotationSpeed;
    age = progress * maxAge;
  }

  double get opacity => math.max(0, 1 - (age / maxAge));
}

class BurstPainter extends CustomPainter {
  final List<BurstParticle> particles;
  final double progress;

  const BurstPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      particle.update(progress);
      
      final paint = Paint()
        ..color = Colors.white.withAlpha((particle.alpha * particle.opacity).toInt())
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.8);

      canvas.save();
      canvas.translate(particle.position.dx, particle.position.dy);
      canvas.rotate(particle.rotation);
      canvas.drawCircle(Offset.zero, particle.size, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}