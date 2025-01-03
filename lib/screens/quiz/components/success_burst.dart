import 'dart:math' as math;
import 'package:flutter/material.dart';

class SuccessBurst extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final Color color;

  const SuccessBurst({
    Key? key,
    required this.child,
    required this.trigger,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  State<SuccessBurst> createState() => _SuccessBurstState();
}

class _SuccessBurstState extends State<SuccessBurst> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final List<Particle> _particles = [];
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SuccessBurst oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _triggerBurst();
    }
  }

  void _triggerBurst() {
    _particles.clear();
    final random = math.Random();
    
    // Create particles in a circular pattern
    for (var i = 0; i < 12; i++) {
      final angle = (i * math.pi * 2) / 12;
      final speed = random.nextDouble() * 2 + 3;
      
      _particles.add(Particle(
        angle: angle,
        speed: speed,
        color: widget.color.withAlpha(200),
      ));
    }
    
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        if (_controller.isAnimating)
          ..._particles.map((particle) {
            final progress = _controller.value;
            final moveDistance = particle.speed * 100 * progress;
            final dx = math.cos(particle.angle) * moveDistance;
            final dy = math.sin(particle.angle) * moveDistance;
            
            return Positioned(
              left: dx,
              top: dy,
              child: Transform.rotate(
                angle: particle.angle,
                child: Opacity(
                  opacity: (1 - progress) * 0.8,
                  child: Container(
                    width: 8,
                    height: 2,
                    decoration: BoxDecoration(
                      color: particle.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}

class Particle {
  final double angle;
  final double speed;
  final Color color;

  Particle({
    required this.angle,
    required this.speed,
    required this.color,
  });
}