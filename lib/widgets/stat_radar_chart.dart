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
    final color = primaryColor ?? Colors.white.withOpacity(0.9);
    final bgColor = backgroundColor ?? Colors.white.withOpacity(0.1);

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
    
    // Draw grid lines
    _drawGridLines(canvas, center, radius);
    
    // Draw the main stats
    _drawScores(canvas, center, radius);
    
    // Draw labels last so they're on top
    _drawLabels(canvas, center, radius);
  }

  void _drawGridLines(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw concentric polygons for the grid
    for (var i = 1; i <= 5; i++) {
      final gridRadius = radius * i / 5;
      final points = _getCircularPoints(center, gridRadius, scores.length);
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      
      for (var point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      path.close();
      canvas.drawPath(path, paint);
    }

    // Draw lines from center to vertices
    final points = _getCircularPoints(center, radius, scores.length);
    for (var point in points) {
      canvas.drawLine(center, point, paint);
    }
  }

  void _drawScores(Canvas canvas, Offset center, double radius) {
    final fillPaint = Paint()
      ..color = primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

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

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final attributes = scores.keys.toList();
    final textStyle = TextStyle(
      color: primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    for (var i = 0; i < attributes.length; i++) {
      final angle = (2 * pi * i) / attributes.length - pi / 2;
      final offset = Offset(
        center.dx + (radius + 30) * cos(angle),
        center.dy + (radius + 30) * sin(angle),
      );

      final textSpan = TextSpan(
        text: attributes[i],
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

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