class Question {
  final int id;
  final String text;
  final List<String>? options;
  final String type;
  final Map<String, Map<String, int>>? attributes;
  final Map<String, int>? scaleAttributes;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.attributes,
    this.scaleAttributes,
  });

  // Helper getters
  bool get isMultipleChoice => type == 'multiple';
  bool get isScale => type == 'scale';
  bool get isSingleChoice => type == 'single';

  // Safely get attribute scores
  Map<String, Map<String, int>> get attributeScores => attributes ?? {};

  Map<String, int> calculateScore(dynamic answer) {
    if (isScale && answer is int && scaleAttributes != null) {
      return _calculateScaleScore(answer);
    } else if (answer is List<String>) {
      return _calculateChoiceScore(answer);
    }
    return {};
  }

  Map<String, int> _calculateScaleScore(int value) {
    final scores = <String, int>{};
    scaleAttributes?.forEach((attribute, baseValue) {
      scores[attribute] = baseValue * value;
    });
    return scores;
  }

  Map<String, int> _calculateChoiceScore(List<String> selectedOptions) {
    final scores = <String, int>{};
    for (final option in selectedOptions) {
      attributes?[option]?.forEach((attribute, value) {
        scores[attribute] = (scores[attribute] ?? 0) + value;
      });
    }
    return scores;
  }
}
