class QuizState {
  final List<dynamic> answers;
  final int currentIndex;
  final bool isComplete;

  QuizState({
    List<dynamic>? answers,
    this.currentIndex = 0,
    this.isComplete = false,
  }) : answers = answers ?? [];

  int get length => answers.length;

  QuizState copyWith({
    List<dynamic>? answers,
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
