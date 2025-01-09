import 'category.dart';

enum QuestionType {
  single,
  multiple,
  scale,
  imageChoice,
  priorityRanking;

  bool get isScale => this == QuestionType.scale;
  bool get isSingleChoice => this == QuestionType.single;
  bool get isMultipleChoice => this == QuestionType.multiple;
  bool get isImageChoice => this == QuestionType.imageChoice;
  bool get isPriorityRanking => this == QuestionType.priorityRanking;
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<String>? options;
  final Map<String, Map<String, int>>? attributes;  // Legacy attribute system
  final Map<String, int>? scaleAttributes;         // Legacy scale system
  final Map<int, String>? scaleLabels;
  final String? encouragingMessage;
  final bool isCheckpoint;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.attributes,
    this.scaleAttributes,
    this.scaleLabels,
    this.encouragingMessage,
    this.isCheckpoint = false,
  });
}