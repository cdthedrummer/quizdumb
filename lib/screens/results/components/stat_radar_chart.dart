import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class StatRadarChart extends StatelessWidget {
  final Map<String, int> scores;
  final double size;
  final Color? primaryColor;
  final Color? backgroundColor;

  const StatRadarChart({
    super.key,
    required this.scores,
    this.size = 300,
    this.primaryColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxScore = scores.values.reduce((max, value) => max > value ? max : value).toDouble();
    final color = primaryColor ?? Theme.of(context).primaryColor;
    final bgColor = backgroundColor ?? color.withAlpha(50);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RadarChartPainter(
          scores: scores,
          maxValue: maxScore,
          primaryColor: color,
          backgroundColor: bgColor,
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final Map<String, int> scores;
  final double maxValue;
  final Color primaryColor;
  final Color backgroundColor;

  _RadarChartPainter({
    required this.scores,
    required this.maxValue,
    required this.primaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;
    
    _drawBackground(canvas, center, radius);
    _drawScores(canvas, center, radius);
    _drawLabels(canvas, center, radius);
  }

  void _drawBackground(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final points = _getCircularPoints(center, radius, scores.length);
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    
    for (var point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();
    
    canvas.drawPath(path, paint);
  }

  void _drawScores(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final points = <Offset>[];
    final values = scores.values.toList();
    
    for (var i = 0; i < scores.length; i++) {
      final angle = (2 * pi * i) / scores.length - pi / 2;
      final value = values[i] / maxValue;
      final point = Offset(
        center.dx + radius * value * cos(angle),
        center.dy + radius * value * sin(angle),
      );
      points.add(point);
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final attributes = scores.keys.toList();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var i = 0; i < attributes.length; i++) {
      final angle = (2 * pi * i) / attributes.length - pi / 2;
      final offset = Offset(
        center.dx + (radius + 20) * cos(angle),
        center.dy + (radius + 20) * sin(angle),
      );

      textPainter.text = TextSpan(
        text: attributes[i],
        style: TextStyle(
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          offset.dx - textPainter.width / 2,
          offset.dy - textPainter.height / 2,
        ),
      );
    }
  }

  List<Offset> _getCircularPoints(Offset center, double radius, int count) {
    final points = <Offset>[];
    for (var i = 0; i < count; i++) {
      final angle = (2 * pi * i) / count - pi / 2;
      points.add(Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      ));
    }
    return points;
  }

  @override
  bool shouldRepaint(_RadarChartPainter oldDelegate) =>
      scores != oldDelegate.scores ||
      maxValue != oldDelegate.maxValue ||
      primaryColor != oldDelegate.primaryColor ||
      backgroundColor != oldDelegate.backgroundColor;
}