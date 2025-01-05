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
  late final AnimationController _controller;
  Offset? _lastPosition;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateParticles);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SliderTrail oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isDragging) {
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
      if (oldWidget.position != widget.position) {
        _emitParticles();
      }
    } else if (!widget.isDragging && oldWidget.isDragging) {
      _controller.stop();
      setState(() => _particles.clear());
    }
  }

  void _emitParticles() {
    if (!mounted) return;
    
    setState(() {
      final numParticles = 4 + _random.nextInt(3); // More particles
      final movingRight = _lastPosition == null || widget.position.dx > _lastPosition!.dx;
      
      for (int i = 0; i < numParticles; i++) {
        // Spray particles in an arc behind the movement
        final baseAngle = movingRight ? math.pi : 0;
        final angleSpread = math.pi / 3; // 60-degree arc
        final angle = baseAngle + ((_random.nextDouble() - 0.5) * angleSpread);
        
        _particles.add(TrailParticle(
          position: widget.position,
          velocity: Offset(
            math.cos(angle) * (2 + _random.nextDouble() * 1), // Faster particles
            math.sin(angle) * (1 + _random.nextDouble() * 0.5),
          ),
          size: 2.5 + _random.nextDouble() * 1.5, // Larger particles
          maxAge: 0.4 + _random.nextDouble() * 0.2, // Longer lifetime
          color: Colors.white.withOpacity(0.8 + _random.nextDouble() * 0.2), // Varying opacity
        ));
      }

      _lastPosition = widget.position;
    });
  }

  void _updateParticles() {
    if (!mounted || _particles.isEmpty) return;
    
    setState(() {
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
  final Color color;
  double age = 0;

  TrailParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.maxAge,
    required this.color,
  });

  void update() {
    position += velocity;
    age += 0.016;
  }

  double get opacity {
    final progress = 1 - (age / maxAge);
    return progress * progress; // Quadratic fade
  }
}

class TrailPainter extends CustomPainter {
  final List<TrailParticle> particles;

  TrailPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5); // Slight glow effect

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(TrailPainter oldDelegate) => true;
}