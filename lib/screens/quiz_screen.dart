// Previous content remains the same until the _calculateResults method

  QuizResult _calculateResults() {
    // Start with base scores of 3
    Map<String, int> scores = {
      'Strength': 3,
      'Dexterity': 3,
      'Constitution': 3,
      'Intelligence': 3,
      'Wisdom': 3,
      'Charisma': 3,
    };

    debugPrint('Starting with base scores: $scores');

    _answers.forEach((questionIndex, selectedOptions) {
      debugPrint('\nProcessing question ${questionIndex + 1}:');
      for (final option in selectedOptions) {
        final attributes = quizQuestions[questionIndex]['attributes'][option] as Map<String, int>;
        debugPrint('  Selected option "$option" adds: $attributes');
        attributes.forEach((attribute, value) {
          scores[attribute] = (scores[attribute] ?? 3) + value;
          debugPrint('    $attribute now at: ${scores[attribute]}');
        });
      }
    });

    // Normalize scores to be between 1-10
    var maxPossibleScore = 10; // Set maximum desired score
    var currentMax = scores.values.reduce((max, value) => max > value ? max : value);
    
    if (currentMax > maxPossibleScore) {
      var scalingFactor = maxPossibleScore / currentMax;
      scores.forEach((key, value) {
        scores[key] = (value * scalingFactor).round();
      });
      debugPrint('Scores normalized with scaling factor $scalingFactor');
    }

    debugPrint('Final scores: $scores');
    return QuizResult(scores: scores);
  }

// Rest of the file remains the same