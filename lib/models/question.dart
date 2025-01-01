class Question {
  final int id;
  final String text;
  final String type;
  final List<String>? options;
  final Map<String, Map<String, int>>? attributes;
  final Map<String, int>? scaleAttributes;
  final Map<int, String>? scaleLabels;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.attributes,
    this.scaleAttributes,
    this.scaleLabels,
  });

  bool get isScale => type == 'scale';
  bool get isSingleChoice => type == 'single';
  bool get isMultipleChoice => type == 'multiple';
}