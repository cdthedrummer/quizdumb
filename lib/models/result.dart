class QuizResult {
  final Map<String, int> scores;
  final String primaryAttribute;
  final int totalQuestions;
  final int answeredQuestions;

  const QuizResult({
    required this.scores,
    required this.primaryAttribute,
    required this.totalQuestions,
    required this.answeredQuestions,
  });

  double get completionPercentage => 
    totalQuestions > 0 ? (answeredQuestions / totalQuestions) * 100 : 0;
}