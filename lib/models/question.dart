class Question {
  final int id;
  final String text;
  final List<String>? options;
  final String type; // 'single', 'multiple', or 'scale'
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

  bool get isMultipleChoice => type == 'multiple';
  bool get isSingleChoice => type == 'single';
  bool get isScale => type == 'scale';

  Map<String, int> calculateScore(dynamic answer) {
    if (isScale && answer is int) {
      return _calculateScaleScore(answer);
    } else if (answer is List<String>) {
      return _calculateChoiceScore(answer);
    }
    return {};
  }

  Map<String, int> _calculateScaleScore(int value) {
    Map<String, int> scores = {};
    scaleAttributes?.forEach((attribute, baseValue) {
      scores[attribute] = baseValue * value;
    });
    return scores;
  }

  Map<String, int> _calculateChoiceScore(List<String> selectedOptions) {
    Map<String, int> scores = {};
    for (final option in selectedOptions) {
      attributes?[option]?.forEach((attribute, value) {
        scores[attribute] = (scores[attribute] ?? 0) + value;
      });
    }
    return scores;
  }
}