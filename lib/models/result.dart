class QuizResult {
  final Map<String, int> scores;
  
  QuizResult({required this.scores});

  String get primaryAttribute {
    return scores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  List<MapEntry<String, int>> get sortedScores {
    var entries = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }
}