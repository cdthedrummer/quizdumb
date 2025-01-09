import 'package:flutter/material.dart';

enum Category {
  physical,
  mental,
  social,
  creative,
  financial,
  personalGrowth;

  String get displayName {
    switch (this) {
      case Category.physical:
        return 'Physical';
      case Category.mental:
        return 'Mental';
      case Category.social:
        return 'Social';
      case Category.creative:
        return 'Creative';
      case Category.financial:
        return 'Financial';
      case Category.personalGrowth:
        return 'Personal Growth';
    }
  }

  String get emoji {
    switch (this) {
      case Category.physical:
        return '💪';
      case Category.mental:
        return '🧠';
      case Category.social:
        return '🤝';
      case Category.creative:
        return '🎨';
      case Category.financial:
        return '💰';
      case Category.personalGrowth:
        return '🌱';
    }
  }

  Color get themeColor {
    switch (this) {
      case Category.physical:
        return const Color(0xFF64B5F6);
      case Category.mental:
        return const Color(0xFF81C784);
      case Category.social:
        return const Color(0xFFFFB74D);
      case Category.creative:
        return const Color(0xFFBA68C8);
      case Category.financial:
        return const Color(0xFF4DB6AC);
      case Category.personalGrowth:
        return const Color(0xFFE57373);
    }
  }
}