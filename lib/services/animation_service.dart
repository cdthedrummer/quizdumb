import 'package:flutter/material.dart';

class AnimationService {
  static Duration get defaultDuration => const Duration(milliseconds: 300);
  static Duration get longDuration => const Duration(milliseconds: 500);
  static Curve get defaultCurve => Curves.easeInOut;

  static Widget fadeTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation.drive(CurveTween(curve: defaultCurve)),
      child: child,
    );
  }

  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    bool reverseSlide = false,
  }) {
    return SlideTransition(
      position: animation.drive(
        Tween(
          begin: Offset(reverseSlide ? -1.0 : 1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: defaultCurve)),
      ),
      child: child,
    );
  }
}