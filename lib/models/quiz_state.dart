class QuizState {
  final Map<int, dynamic> answers;  // Changed from List to Map for better typing
  final int currentIndex;
  final bool isComplete;

  QuizState({
    Map<int, dynamic>? answers,
    this.currentIndex = 0,
    this.isComplete = false,
  }) : answers = answers ?? {};

  // Helper methods for type safety
  List<String>? getChoiceAnswer(int index) {
    final answer = answers[index];
    return answer is List<String> ? answer : null;
  }

  int? getScaleAnswer(int index) {
    final answer = answers[index];
    return answer is int ? answer : null;
  }

  bool hasAnswer(int index) => answers.containsKey(index);

  QuizState copyWith({
    Map<int, dynamic>? answers,
    int? currentIndex,
    bool? isComplete,
  }) {
    return QuizState(
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}