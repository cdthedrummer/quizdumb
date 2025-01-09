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

  Map<Category, double> calculateCategoryScores() {
    final scores = <Category, double>{};
    for (final category in Category.values) {
      scores[category] = 0.0;
    }

    int totalQuestions = 0;
    for (final question in _questions) {
      final answer = _answers[question.id];
      if (answer == null) continue;

      // Handle new scoring system
      if (question.categoryWeights != null) {
        question.categoryWeights!.forEach((category, weight) {
          if (question.isScale) {
            final value = double.tryParse(answer.first) ?? 0.0;
            scores[category] = (scores[category] ?? 0.0) + (value / 5.0) * weight;
          } else {
            scores[category] = (scores[category] ?? 0.0) + weight;
          }
        });
      }
      // Handle legacy scoring system
      else if (question.scaleAttributes != null && question.isScale) {
        final value = int.tryParse(answer.first) ?? 0;
        question.scaleAttributes!.forEach((attr, weight) {
          // Convert legacy attributes to categories
          final category = _mapAttributeToCategory(attr);
          if (category != null) {
            scores[category] = (scores[category] ?? 0.0) + (value / 5.0) * weight;
          }
        });
      }
      else if (question.attributes != null) {
        for (final ans in answer) {
          final attrs = question.attributes![ans];
          if (attrs != null) {
            attrs.forEach((attr, value) {
              final category = _mapAttributeToCategory(attr);
              if (category != null) {
                scores[category] = (scores[category] ?? 0.0) + value;
              }
            });
          }
        }
      }
      totalQuestions++;
    }

    // Normalize scores to 0-1 range
    if (totalQuestions > 0) {
      scores.forEach((category, score) {
        scores[category] = (score / (totalQuestions * 5)).clamp(0.0, 1.0);
      });
    }

    return scores;
  }

  Category? _mapAttributeToCategory(String attribute) {
    // Map legacy attributes to new categories
    switch (attribute.toLowerCase()) {
      case 'strength':
      case 'dexterity':
      case 'constitution':
        return Category.physical;
      case 'intelligence':
      case 'wisdom':
        return Category.mental;
      case 'charisma':
        return Category.social;
      default:
        return null;
    }
  }
}