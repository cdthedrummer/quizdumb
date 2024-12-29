class Question {
  final int id;
  final String text;
  final List<String>? options;
  final String type;
  final Map<String, Map<String, int>>? attributes;
  final Map<String, int>? scaleAttributes;
  final Map<int, String>? scaleLabels;  // Added this field

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.attributes,
    this.scaleAttributes,
    this.scaleLabels,
  }) : assert(
          (type == 'scale' && scaleAttributes != null) ||
          ((type == 'single' || type == 'multiple') &&
              options != null &&
              attributes != null),
        );

  bool get isMultipleChoice => type == 'multiple';
  bool get isSingleChoice => type == 'single';
  bool get isScale => type == 'scale';

  String getScaleLabel(int value) {
    if (isScale && scaleLabels != null && scaleLabels!.containsKey(value)) {
      return scaleLabels![value]!;
    }
    return value.toString();
  }
}