import 'dart:math' as math;
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
  final math.Random _random = math.Random();
  Offset? _lastPosition;
  
  @override
  void didUpdateWidget(SliderTrail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDragging && (oldWidget.position != widget.position)) {
      _emitParticles();
    } else if (!widget.isDragging && oldWidget.isDragging) {
      setState(() => _particles.clear());
    }
  }

  void _emitParticles() {
    setState(() {
      final numParticles = 3 + _random.nextInt(3);
      for (int i = 0; i < numParticles; i++) {
        final angle = ((_random.nextDouble() - 0.5) * math.pi / 2) + 
            (_lastPosition != null && widget.position.dx > _lastPosition!.dx ? math.pi : 0);
        
        _particles.add(TrailParticle(
          position: widget.position,
          velocity: Offset(
            math.cos(angle) * (1 + _random.nextDouble()),
            math.sin(angle) * (1 + _random.nextDouble()),
          ),
          size: 1.5 + _random.nextDouble(),
          maxAge: 0.2 + _random.nextDouble() * 0.1,
        ));
      }

      for (int i = _particles.length - 1; i >= 0; i--) {
        final particle = _particles[i];
        particle.update();
        if (particle.age >= particle.maxAge) {
          _particles.removeAt(i);
        }
      }

      _lastPosition = widget.position;
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
    age += 0.016;
  }

  double get opacity {
    final progress = 1 - (age / maxAge);
    return progress * progress; // Quadratic fade without pow()
  }
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