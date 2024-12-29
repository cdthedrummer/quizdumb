class Question {
  final int id;
  final String text;
  final List<String> options;
  final String type;
  final Map<String, Map<String, int>> attributes;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.type,
    required this.attributes,
  });

  bool get isMultipleChoice => type == 'multiple';

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      text: map['text'] as String,
      options: List<String>.from(map['options'] as List),
      type: map['type'] as String,
      attributes: Map<String, Map<String, int>>.from(
        (map['attributes'] as Map).map(
          (key, value) => MapEntry(
            key as String,
            Map<String, int>.from(value as Map),
          ),
        ),
      ),
    );
  }

  @override
  String toString() => 'Question(id: $id, text: $text, type: $type)';
}