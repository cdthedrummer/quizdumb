import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../data/questions.dart';

enum QuizStatus {
  notStarted,
  inProgress,
  complete,
}

class QuizProvider with ChangeNotifier {
  int _currentIndex = 0;
  final Map<String, List<String>> _answers = {};
  QuizStatus _status = QuizStatus.notStarted;
  final List<Question> _questions = questions;

  QuizStatus get status => _status;
  int get currentQuestionIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  double get progress => _currentIndex / (_questions.length - 1);
  Map<String, double> get scores => calculateScores();

  void startQuiz() {
    _status = QuizStatus.inProgress;
    _currentIndex = 0;
    _answers.clear();
    notifyListeners();
  }

  void resetQuiz() {
    _status = QuizStatus.notStarted;
    _currentIndex = 0;
    _answers.clear();
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    } else {
      _status = QuizStatus.complete;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  List<String>? getAnswerForQuestion(String questionId) {
    return _answers[questionId];
  }

  void answerQuestion(String questionId, List<String> answer) {
    _answers[questionId] = answer;
    notifyListeners();
  }

  Map<String, double> calculateScores() {
    final scores = <String, double>{};
    final totals = <String, int>{};

    for (final question in _questions) {
      final answer = _answers[question.id];
      if (answer == null) continue;

      if (question.isScale && question.scaleAttributes != null) {
        final value = int.tryParse(answer.first) ?? 4;
        for (final entry in question.scaleAttributes!.entries) {
          scores[entry.key] = (scores[entry.key] ?? 0) + value * entry.value;
          totals[entry.key] = (totals[entry.key] ?? 0) + 7 * entry.value;
        }
      } else if (question.attributes != null) {
        for (final ans in answer) {
          final attrs = question.attributes![ans];
          if (attrs != null) {
            attrs.forEach((attr, value) {
              scores[attr] = (scores[attr] ?? 0) + value;
              totals[attr] = (totals[attr] ?? 0) + value;
            });
          }
        }
      }
    }

    // Normalize scores
    final normalizedScores = <String, double>{};
    scores.forEach((key, value) {
      final total = totals[key] ?? 1;
      normalizedScores[key] = (value / total).clamp(0.0, 1.0);
    });

    return normalizedScores;
  }
}