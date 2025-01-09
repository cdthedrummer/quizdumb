enum QuestionType {
  single,
  multiple,
  scale,
  imageChoice,
  priorityRanking
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<String>? options;
  final Map<String, Map<String, int>>? attributes;  // Keep for backward compatibility
  final Map<Category, double>? categoryWeights;     // New scoring system
  final Map<String, int>? scaleAttributes;         // Keep for backward compatibility
  final Map<int, String>? scaleLabels;
  final String? encouragingMessage;
  final bool isCheckpoint;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.attributes,
    this.categoryWeights,
    this.scaleAttributes,
    this.scaleLabels,
    this.encouragingMessage,
    this.isCheckpoint = false,
  });

  bool get isScale => type == QuestionType.scale;
  bool get isSingleChoice => type == QuestionType.single;
  bool get isMultipleChoice => type == QuestionType.multiple;
  bool get isImageChoice => type == QuestionType.imageChoice;
  bool get isPriorityRanking => type == QuestionType.priorityRanking;
}