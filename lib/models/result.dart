class QuizResult {
  final Map<String, int> scores;

  const QuizResult({
    required this.scores,
  });

  // Get the dominant attribute
  String get primaryAttribute {
    String highest = 'Strength';
    int maxScore = scores['Strength'] ?? 0;
    
    scores.forEach((attribute, score) {
      if (score > maxScore) {
        highest = attribute;
        maxScore = score;
      }
    });
    
    return highest;
  }

  @override
  String toString() => 'QuizResult(scores: $scores)';
}