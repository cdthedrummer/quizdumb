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
  
  @override
  void didUpdateWidget(SliderTrail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDragging && (oldWidget.position != widget.position)) {
      _updateParticles();
    }
  }

  void _updateParticles() {
    setState(() {
      // Add new particles at current position
      for (int i = 0; i < 2; i++) {
        _particles.add(TrailParticle(
          position: widget.position,
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 0.5,
            (_random.nextDouble() - 0.5) * 0.5 - 1,
          ),
          size: _random.nextDouble() * 2 + 1,
          maxAge: 0.5 + _random.nextDouble() * 0.3,
        ));
      }

      // Update and remove old particles
      for (int i = _particles.length - 1; i >= 0; i--) {
        final particle = _particles[i];
        particle.update();
        if (particle.age >= particle.maxAge) {
          _particles.removeAt(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_particles.isNotEmpty)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: TrailPainter(particles: _particles),
                size: Size.infinite,
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
  final double maxAge;
  double age = 0;

  TrailParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.maxAge,
  });

  void update() {
    position += velocity;
    age += 0.016; // Roughly 60fps
  }

  double get opacity => (1 - (age / maxAge));
}

class TrailPainter extends CustomPainter {
  final List<TrailParticle> particles;

  TrailPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = Colors.white.withAlpha((particle.opacity * 30).toInt())
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(TrailPainter oldDelegate) => true;
}