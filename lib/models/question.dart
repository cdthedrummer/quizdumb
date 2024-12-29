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
  }) : assert(
          (type == 'scale' && scaleAttributes != null) ||
              ((type == 'single' || type == 'multiple') &&
                  options != null &&
                  attributes != null),
          'Scale questions need scaleAttributes, others need options and attributes',
        );

  // Helper getters
  bool get isMultipleChoice => type == 'multiple';
  bool get isScale => type == 'scale';
  bool get isSingleChoice => type == 'single';

  // Score calculation helpers
  Map<String, int> calculateScore(dynamic answer) {
    if (isScale) {
      return _calculateScaleScore(answer as int);
    } else {
      return _calculateChoiceScore(answer as List<String>);
    }
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

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      text: map['text'] as String,
      type: map['type'] as String,
      options: map['options'] != null 
          ? List<String>.from(map['options'] as List)
          : null,
      attributes: map['attributes'] != null
          ? Map<String, Map<String, int>>.from(
              (map['attributes'] as Map).map(
                (key, value) => MapEntry(
                  key as String,
                  Map<String, int>.from(value as Map),
                ),
              ),
            )
          : null,
      scaleAttributes: map['scaleAttributes'] != null
          ? Map<String, int>.from(map['scaleAttributes'] as Map)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'type': type,
      if (options != null) 'options': options,
      if (attributes != null) 'attributes': attributes,
      if (scaleAttributes != null) 'scaleAttributes': scaleAttributes,
    };
  }

  @override
  String toString() => 'Question(id: $id, text: $text, type: $type)';
}
