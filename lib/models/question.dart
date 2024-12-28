import 'package:flutter/foundation.dart';

enum QuestionType {
  singleChoice,
  multipleChoice,
  scale
}

class Question {
  final String text;
  final List<String> options;
  final QuestionType type;
  final Map<String, List<double>> attributeScores;
  final bool autoProgress;

  const Question({
    required this.text,
    required this.options,
    required this.type,
    required this.attributeScores,
    this.autoProgress = true,
  });

  @override
  String toString() {
    if (kDebugMode) {
      return 'Question(text: $text, type: $type, options: ${options.length})';
    }
    return super.toString();
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      options: List<String>.from(json['options']),
      type: QuestionType.values.byName(json['type']),
      attributeScores: Map<String, List<double>>.from(
        json['attributeScores'].map((key, value) => 
          MapEntry(key, List<double>.from(value))
        ),
      ),
      autoProgress: json['autoProgress'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'options': options,
    'type': type.name,
    'attributeScores': attributeScores,
    'autoProgress': autoProgress,
  };
}
