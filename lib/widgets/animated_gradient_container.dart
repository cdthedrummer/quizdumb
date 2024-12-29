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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withAlpha(204),
            Theme.of(context).primaryColorDark,
          ],
        ),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}