import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class StatRadarChart extends StatelessWidget {
  final Map<String, double> scores;
  
  const StatRadarChart({
    super.key,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadarChartPainter(scores),
      size: const Size(300, 300),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final Map<String, double> scores;
  
  _RadarChartPainter(this.scores);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    final statPoints = scores.keys.toList();
    final angleStep = (2 * pi) / statPoints.length;

    // Draw background grid
    _drawGrid(canvas, center, radius, statPoints.length, angleStep);
    
    // Draw stat lines
    _drawStats(canvas, center, radius, statPoints, angleStep);
    
    // Draw labels
    _drawLabels(canvas, center, radius * 1.2, statPoints, angleStep);
  }

  void _drawGrid(Canvas canvas, Offset center, double radius, int points, double angleStep) {
    final gridPaint = Paint()
      ..color = Colors.white.withAlpha(51)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw rings
    for (var i = 1; i <= 5; i++) {
      final currentRadius = radius * (i / 5);
      final path = Path();
      
      for (var j = 0; j < points; j++) {
        final angle = -pi / 2 + (j * angleStep);
        final x = center.dx + cos(angle) * currentRadius;
        final y = center.dy + sin(angle) * currentRadius;
        
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }
  }

  void _drawStats(Canvas canvas, Offset center, double radius, List<String> statPoints, double angleStep) {
    final statPaint = Paint()
      ..color = Colors.white.withAlpha(179)
      ..style = PaintingStyle.fill;

    final path = Path();
    
    for (var i = 0; i < statPoints.length; i++) {
      final score = scores[statPoints[i]] ?? 0.0;
      final angle = -pi / 2 + (i * angleStep);
      final x = center.dx + cos(angle) * (radius * score);
      final y = center.dy + sin(angle) * (radius * score);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    path.close();
    canvas.drawPath(path, statPaint);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius, List<String> statPoints, double angleStep) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (var i = 0; i < statPoints.length; i++) {
      final angle = -pi / 2 + (i * angleStep);
      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;

      textPainter.text = TextSpan(
        text: statPoints[i],
        style: TextStyle(
          color: Colors.white.withAlpha(230),
          fontSize: 12,
          fontFamily: 'Quicksand',
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          y - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_RadarChartPainter oldDelegate) {
    return oldDelegate.scores != scores;
  }
}