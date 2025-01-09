import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../models/category.dart';
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

  void startQuiz() {
    _status = QuizStatus.inProgress;
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
    final attributeMaxValues = <String, double>{};

    // First pass: calculate maximum possible values
    for (final question in _questions) {
      if (question.scaleAttributes != null) {
        question.scaleAttributes!.forEach((attr, weight) {
          attributeMaxValues[attr] = (attributeMaxValues[attr] ?? 0) + (weight * 7);
        });
      } else if (question.attributes != null) {
        question.attributes!.values.forEach((attrs) {
          attrs.forEach((attr, value) {
            attributeMaxValues[attr] = (attributeMaxValues[attr] ?? 0) + value;
          });
        });
      }
    }

    // Second pass: calculate actual scores
    for (final question in _questions) {
      final answer = _answers[question.id];
      if (answer == null) continue;

      if (question.isScale && question.scaleAttributes != null) {
        final value = int.tryParse(answer.first) ?? 4;
        question.scaleAttributes!.forEach((attr, weight) {
          scores[attr] = (scores[attr] ?? 0) + (value * weight);
        });
      } else if (question.attributes != null) {
        for (final ans in answer) {
          final attrs = question.attributes![ans];
          if (attrs != null) {
            attrs.forEach((attr, value) {
              scores[attr] = (scores[attr] ?? 0) + value;
            });
          }
        }
      }
    }

    // Normalize scores to 0-1 range
    final normalizedScores = <String, double>{};
    scores.forEach((attr, score) {
      final maxValue = attributeMaxValues[attr] ?? 1;
      normalizedScores[attr] = (score / maxValue).clamp(0.0, 1.0);
    });

    return normalizedScores;
  }
}