import 'dart:math';
import 'package:flutter/material.dart';

class SliderTrail extends StatefulWidget {
  final Widget child;
  final bool isDragging;
  final Offset position;

  const SliderTrail({
    Key? key,
    required this.child,
    required this.isDragging,
    required this.position,
  }) : super(key: key);

  @override
  State<SliderTrail> createState() => _SliderTrailState();
}

class _SliderTrailState extends State<SliderTrail> with SingleTickerProviderStateMixin {
  final List<TrailParticle> _particles = [];
  final Random _random = Random();
  
  void _updateParticles() {
    if (!widget.isDragging) {
      _particles.clear();
      return;
    }

    // Add new particles
    for (int i = 0; i < 2; i++) {
      _particles.add(TrailParticle(
        position: widget.position,
        velocity: Offset(
          (_random.nextDouble() - 0.5) * 0.5,
          (_random.nextDouble() - 0.5) * 0.5,
        ),
        size: 1 + _random.nextDouble() * 2,
        lifespan: 0.8 + _random.nextDouble() * 0.4,
      ));
    }

    // Update existing particles
    for (int i = _particles.length - 1; i >= 0; i--) {
      _particles[i].update();
      if (_particles[i].isDead) {
        _particles.removeAt(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateParticles();
    
    return Stack(
      children: [
        widget.child,
        if (_particles.isNotEmpty)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: TrailPainter(particles: _particles),
              ),
            ),
          ),
      ],
    );
  }
}

class TrailParticle {
  Offset position;
  final Offset velocity;
  final double size;
  final double lifespan;
  double age = 0;

  TrailParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.lifespan,
  });

  bool get isDead => age >= lifespan;

  void update() {
    position += velocity;
    age += 0.016; // Roughly 60fps
  }

  double get opacity => (1 - (age / lifespan));
}

class TrailPainter extends CustomPainter {
  final List<TrailParticle> particles;

  TrailPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = Colors.white.withAlpha((particle.opacity * 40).toInt())
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(TrailPainter oldDelegate) => true;
}