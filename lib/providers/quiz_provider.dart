import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> _questions;
  Map<int, List<int>> _answers = {};
  int _currentIndex = 0;

  QuizProvider(this._questions) {
    debugPrint('Initializing QuizProvider with ${_questions.length} questions');
  }

  Question get currentQuestion => _questions[_currentIndex];
  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  double get progress => (_currentIndex + 1) / _questions.length;
  List<int> get currentAnswers => _answers[_currentIndex] ?? [];

  void updateScores(Map<String, num> scores) {
    debugPrint('Updating scores: $scores');
    for (var questionIndex in _answers.keys) {
      final question = _questions[questionIndex];
      for (var answerIndex in _answers[questionIndex]!) {
        if (answerIndex >= 0 && answerIndex < question.options.length) {
          final option = question.options[answerIndex];
          final attributes = question.attributeScores[option];
          if (attributes != null) {
            attributes.forEach((attribute, value) {
              scores[attribute] = (scores[attribute] ?? 0) + value;
            });
          }
        }
      }
    }
    notifyListeners();
  }
}