import 'dart:math' show pi, cos, sin;
import 'package:flutter/material.dart';

class StatRadarChart extends StatelessWidget {
  final Map<String, int> scores;
  final double maxScore;

  const StatRadarChart({
    Key? key,
    required this.scores,
    this.maxScore = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building radar chart with scores: $scores');
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _RadarChartPainter(
          scores: scores,
          maxScore: maxScore,
          textColor: Colors.white,
          fillColor: Colors.white.withOpacity(0.3),
          strokeColor: Colors.white.withOpacity(0.7),
          gridColor: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final Map<String, int> scores;
  final double maxScore;
  final Color textColor;
  final Color fillColor;
  final Color strokeColor;
  final Color gridColor;

  static const statOrder = [
    'Strength',
    'Dexterity',
    'Constitution',
    'Intelligence',
    'Wisdom',
    'Charisma',
  ];

  _RadarChartPainter({
    required this.scores,
    required this.maxScore,
    required this.textColor,
    required this.fillColor,
    required this.strokeColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35; // Slightly smaller to accommodate labels
    final double angleStep = (2 * pi) / statOrder.length;

    // Draw grid lines
    _drawGrid(canvas, center, radius, angleStep);

    // Draw stat values
    _drawStats(canvas, center, radius, angleStep);

    // Draw labels
    _drawLabels(canvas, center, radius, angleStep);
  }

  void _drawGrid(Canvas canvas, Offset center, double radius, double angleStep) {
    final gridPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw concentric hexagons
    for (int i = 1; i <= 5; i++) {
      final path = Path();
      final currentRadius = radius * (i / 5);

      for (int j = 0; j < statOrder.length; j++) {
        final angle = -pi / 2 + (j * angleStep);
        final point = Offset(
          center.dx + cos(angle) * currentRadius,
          center.dy + sin(angle) * currentRadius,
        );

        if (j == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Draw spokes
    for (int i = 0; i < statOrder.length; i++) {
      final angle = -pi / 2 + (i * angleStep);
      canvas.drawLine(
        center,
        Offset(
          center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius,
        ),
        gridPaint,
      );
    }
  }

  void _drawStats(Canvas canvas, Offset center, double radius, double angleStep) {
    final statPath = Path();
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < statOrder.length; i++) {
      final stat = statOrder[i];
      final score = scores[stat] ?? 0;
      final percentage = score / maxScore;
      final angle = -pi / 2 + (i * angleStep);
      final point = Offset(
        center.dx + cos(angle) * radius * percentage,
        center.dy + sin(angle) * radius * percentage,
      );

      if (i == 0) {
        statPath.moveTo(point.dx, point.dy);
      } else {
        statPath.lineTo(point.dx, point.dy);
      }
    }
    statPath.close();

    canvas.drawPath(statPath, fillPaint);
    canvas.drawPath(statPath, strokePaint);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius, double angleStep) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 0; i < statOrder.length; i++) {
      final stat = statOrder[i];
      final angle = -pi / 2 + (i * angleStep);
      
      // Position labels slightly outside the chart
      final labelRadius = radius * 1.2;
      final point = Offset(
        center.dx + cos(angle) * labelRadius,
        center.dy + sin(angle) * labelRadius,
      );

      textPainter.text = TextSpan(
        text: stat,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w500,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          point.dx - textPainter.width / 2,
          point.dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_RadarChartPainter oldDelegate) =>
      scores != oldDelegate.scores;
}