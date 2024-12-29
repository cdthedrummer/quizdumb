import 'package:flutter/material.dart';

class AnimatedGradientContainer extends StatelessWidget {
  final Widget child;

  const AnimatedGradientContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8B7BC4),  // Lighter purple blue at top
            Color(0xFF4267B2),  // Darker blue at bottom
          ],
        ),
      ),
      child: child,
    );
  }
}