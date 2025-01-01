class Question {
  final int id;
  final String text;
  final String type;  // 'single', 'multiple', or 'scale'
  final List<String>? options;
  final Map<String, Map<String, int>>? attributes;  // For choice questions
  final Map<String, int>? scaleAttributes;  // For scale questions
  final Map<int, String>? scaleLabels;  // For scale questions

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.attributes,
    this.scaleAttributes,
    this.scaleLabels,
  }) : assert(
          (type == 'scale' && scaleAttributes != null && scaleLabels != null) ||
          (type != 'scale' && options != null && attributes != null),
          'Question must have either scale attributes or choice options'
        );

  bool get isMultipleChoice => type == 'multiple';
  bool get isSingleChoice => type == 'single';
  bool get isScale => type == 'scale';
}