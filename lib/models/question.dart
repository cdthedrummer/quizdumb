class Question {
  final String text;
  final List<String> options;
  final Map<String, int> attributeScores;
  final bool isMultiSelect;
  List<int> selectedAnswers = [];

  Question({
    required this.text,
    required this.options,
    required this.attributeScores,
    this.isMultiSelect = false,
  });

  void selectAnswer(int index) {
    if (isMultiSelect) {
      if (selectedAnswers.contains(index)) {
        selectedAnswers.remove(index);
      } else {
        selectedAnswers.add(index);
      }
    } else {
      selectedAnswers = [index];
    }
  }

  bool isSelected(int index) => selectedAnswers.contains(index);
  
  bool get isAnswered => selectedAnswers.isNotEmpty;
}