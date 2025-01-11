import 'package:flutter/material.dart';

class QuizUtils {
  static int parseScaleValue(String? value, {int defaultValue = 4}) {
    return int.tryParse(value ?? '') ?? defaultValue;
  }

  static Color withAlpha255(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  static double normalizeValue(double value, double min, double max) {
    return (value - min) / (max - min);
  }

  static String getDescriptiveScaleLabel(int value, Map<int, String> labels) {
    if (value <= 2) return labels[1] ?? '';
    if (value >= 6) return labels[7] ?? '';
    return labels[4] ?? '';
  }

  static List<T> topElements<T>(Map<T, num> map, int count, 
      {bool ascending = false}) {
    final sorted = map.entries.toList()
      ..sort((a, b) => ascending 
          ? a.value.compareTo(b.value)
          : b.value.compareTo(a.value));
    return sorted.take(count).map((e) => e.key).toList();
  }

  static Map<String, double> normalizeScores(
      Map<String, double> scores, 
      Map<String, int> totals) {
    final normalized = <String, double>{};
    scores.forEach((key, value) {
      final total = totals[key] ?? 1;
      normalized[key] = (value / total).clamp(0.0, 1.0);
    });
    return normalized;
  }
}