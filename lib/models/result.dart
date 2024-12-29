class QuizResult {
  final Map<String, int> scores;

  const QuizResult({
    required this.scores,
  });

  @override
  String toString() => 'QuizResult(scores: $scores)';
}