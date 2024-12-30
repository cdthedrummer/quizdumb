import '../models/question.dart';
import '../models/result.dart';

class QuizService {
  Map<String, int> _initializeBaseScores() {
    return {
      'Strength': 3,
      'Dexterity': 3,
      'Constitution': 3,
      'Intelligence': 3,
      'Wisdom': 3,
      'Charisma': 3,
    };
  }

  QuizResult calculateResults(Map<int, dynamic> answers, List<Question> questions) {
    Map<String, int> scores = _initializeBaseScores();

    answers.forEach((index, answer) {
      final question = questions[index];
      if (question.isScale && answer is double) {
        _processScaleAnswer(scores, question, answer);
      } else if (answer is List<String>) {
        _processMultiAnswer(scores, question, answer);
      }
    });

    return QuizResult(scores: scores);
  }

  void _processScaleAnswer(Map<String, int> scores, Question question, double answer) {
    question.scaleAttributes?.forEach((attribute, baseValue) {
      scores[attribute] = (scores[attribute] ?? 3) + 
          (baseValue * ((answer.round() - 4) / 3)).round();
    });
  }

  void _processMultiAnswer(Map<String, int> scores, Question question, List<String> answers) {
    for (final option in answers) {
      question.attributes?[option]?.forEach((attribute, value) {
        scores[attribute] = (scores[attribute] ?? 3) + value;
      });
    }
  }
}