import 'dart:math';
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
  final Random _random = Random();
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800), // Longer animation
      vsync: this,
    );

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _createParticles(Offset center) {
    _particles.clear();
    
    // Create more, smaller particles
    for (int i = 0; i < 30; i++) { // Increased from 12 to 30
      // Calculate angle spread (only upward fountain)
      double angle = -pi/2 + (pi/3 * _random.nextDouble() - pi/6); // -60° to -120°
      
      // Vary speeds more for fountain effect
      double speed = 1 + _random.nextDouble() * 2;
      
      // Add gravity effect
      _particles.add(BurstParticle(
        position: center,
        velocity: Offset(
          cos(angle) * speed,
          sin(angle) * speed,
        ),
        acceleration: const Offset(0, 0.1), // Gravity
        size: 1 + _random.nextDouble() * 2, // Smaller particles (1-3px)
        color: Colors.white.withOpacity(0.1 + _random.nextDouble() * 0.2), // More transparent
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
  Offset velocity;
  final Offset acceleration;
  final double size;
  final Color color;

  BurstParticle({
    required this.position,
    required this.velocity,
    required this.acceleration,
    required this.size,
    required this.color,
  });

  void update(double progress) {
    velocity += acceleration; // Apply gravity
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
        ..color = particle.color.withOpacity(1 - progress)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5); // Slight glow

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(BurstPainter oldDelegate) => true;
}