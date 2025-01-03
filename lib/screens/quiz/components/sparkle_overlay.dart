import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SparkleOverlay extends StatefulWidget {
  final Widget child;
  final bool triggerEffect;

  const SparkleOverlay({
    Key? key, 
    required this.child,
    required this.triggerEffect,
  }) : super(key: key);

  @override
  State<SparkleOverlay> createState() => _SparkleOverlayState();
}

class _SparkleOverlayState extends State<SparkleOverlay> with SingleTickerProviderStateMixin {
  final List<SparkleParticle> _particles = [];
  final Random _random = Random();
  
  @override
  void didUpdateWidget(SparkleOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.triggerEffect && !oldWidget.triggerEffect) {
      _createParticles();
    }
  }

  void _createParticles() {
    // Clear old particles
    _particles.clear();
    
    // Create new particles
    for (int i = 0; i < 15; i++) {
      _particles.add(SparkleParticle(
        position: Offset(
          _random.nextDouble() * MediaQuery.of(context).size.width,
          _random.nextDouble() * MediaQuery.of(context).size.height,
        ),
        velocity: Offset(
          (_random.nextDouble() - 0.5) * 3,
          -_random.nextDouble() * 4 - 2,
        ),
        color: Colors.white.withAlpha((_random.nextDouble() * 155 + 100).toInt()),
        size: _random.nextDouble() * 6 + 2,
      ));
    }
    
    // Start animation
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_particles.isEmpty) {
        timer.cancel();
        return;
      }

      setState(() {
        for (int i = _particles.length - 1; i >= 0; i--) {
          final particle = _particles[i];
          particle.update();
          
          // Remove particles that have faded out
          if (particle.alpha <= 0) {
            _particles.removeAt(i);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        CustomPaint(
          painter: SparklePainter(particles: _particles),
          size: Size.infinite,
        ),
      ],
    );
  }
}

class SparkleParticle {
  Offset position;
  Offset velocity;
  Color color;
  double size;
  double alpha = 1.0;

  SparkleParticle({
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
  });

  void update() {
    position += velocity;
    alpha -= 0.02;
    size *= 0.98;
  }
}

class SparklePainter extends CustomPainter {
  final List<SparkleParticle> particles;

  SparklePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withAlpha((particle.alpha * 255).toInt())
        ..style = PaintingStyle.fill;

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(SparklePainter oldDelegate) => true;
}