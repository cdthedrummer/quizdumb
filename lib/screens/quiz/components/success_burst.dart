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
      duration: const Duration(milliseconds: 1200), // Longer animation
      vsync: this,
    );

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _createParticles(Offset center) {
    _particles.clear();
    
    // Create many more smaller particles
    for (int i = 0; i < 50; i++) { // Increased from 30 to 50
      // Calculate a fountain-like spread angle (-100° to -80° from horizontal)
      double angle = -math.pi * (0.44 + _random.nextDouble() * 0.12);
      
      // Vary the initial velocities
      double speed = 1 + _random.nextDouble() * 3;
      
      // Create particle with gravity and drag effects
      _particles.add(BurstParticle(
        position: center,
        velocity: Offset(
          math.cos(angle) * speed,
          math.sin(angle) * speed,
        ),
        // Add gravity and air resistance
        acceleration: const Offset(0, 0.15), // Increased gravity
        drag: 0.97 + _random.nextDouble() * 0.02, // Air resistance
        size: 0.8 + _random.nextDouble() * 1.2, // Smaller particles (0.8-2px)
        color: Colors.white.withOpacity(0.04 + _random.nextDouble() * 0.08), // More transparent
        rotationSpeed: (_random.nextDouble() - 0.5) * 0.2, // Slight rotation
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
  final double drag;
  final double size;
  final Color color;
  final double rotationSpeed;
  double rotation = 0;

  BurstParticle({
    required this.position,
    required this.velocity,
    required this.acceleration,
    required this.drag,
    required this.size,
    required this.color,
    required this.rotationSpeed,
  });

  void update(double progress) {
    // Apply gravity
    velocity += acceleration;
    
    // Apply drag (air resistance)
    velocity = velocity.scale(drag, drag);
    
    // Update position
    position += velocity;
    
    // Update rotation
    rotation += rotationSpeed;
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
        ..color = particle.color.withOpacity((1 - progress) * 0.8) // Fade out
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.8); // Soft glow

      // Draw with slight rotation for more organic feel
      canvas.save();
      canvas.translate(particle.position.dx, particle.position.dy);
      canvas.rotate(particle.rotation);
      canvas.drawCircle(Offset.zero, particle.size, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(BurstPainter oldDelegate) => true;
}