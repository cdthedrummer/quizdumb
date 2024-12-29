  QuizResult _calculateResults() {
    Map<String, int> scores = {
      'Strength': 3,
      'Dexterity': 3,
      'Constitution': 3,
      'Intelligence': 3,
      'Wisdom': 3,
      'Charisma': 3,
    };

    _answers.forEach((questionIndex, answer) {
      final question = widget.questions[questionIndex];
      
      if (question.isScale) {
        // Handle scale question scores
        final scaleValue = answer as int;
        question.scaleAttributes?.forEach((attribute, baseValue) {
          scores[attribute] = (scores[attribute] ?? 3) + (baseValue * scaleValue);
        });
      } else {
        // Handle choice question scores
        final selectedOptions = answer as List<String>;
        for (final option in selectedOptions) {
          question.attributes?[option]?.forEach((attribute, value) {
            scores[attribute] = (scores[attribute] ?? 3) + value;
          });
        }
      }
    });

    // Normalize scores
    scores.forEach((key, value) {
      scores[key] = value.clamp(1, 20);
    });

    return QuizResult(scores: scores);
  }