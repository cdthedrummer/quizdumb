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
      _emitParticles();
    } else if (!widget.isDragging && oldWidget.isDragging) {
      // Clear particles when drag ends
      setState(() => _particles.clear());
    }
  }

  void _emitParticles() {
    setState(() {
      // Emit 3-5 particles from the thumb position
      final numParticles = 3 + _random.nextInt(3);
      for (int i = 0; i < numParticles; i++) {
        // Calculate spread angle (-45 to +45 degrees from horizontal)
        final angle = ((_random.nextDouble() - 0.5) * pi / 2) + 
            (widget.position.dx > _lastPosition?.dx ? pi : 0); // Adjust based on drag direction
        
        _particles.add(TrailParticle(
          position: widget.position,
          velocity: Offset(
            cos(angle) * (1 + _random.nextDouble()),
            sin(angle) * (1 + _random.nextDouble()),
          ),
          size: 1.5 + _random.nextDouble(),
          maxAge: 0.2 + _random.nextDouble() * 0.1, // Shorter lifespan
        ));
      }

      // Update existing particles
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

  Offset? _lastPosition;

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

  double get opacity => pow((1 - (age / maxAge)), 2).toDouble(); // Quadratic fade
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