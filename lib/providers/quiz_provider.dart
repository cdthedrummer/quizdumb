import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  List<Question> _questions = [];
  Map<String, int> _scores = {
    'strength': 0,
    'intelligence': 0,
    'wisdom': 0,
    'dexterity': 0,
    'charisma': 0,
    'constitution': 0,
  };

  // Getters
  int get currentQuestionIndex => _currentQuestionIndex;
  List<Question> get questions => _questions;
  Map<String, int> get scores => _scores;
  Question? get currentQuestion => 
    _questions.isNotEmpty && _currentQuestionIndex < _questions.length 
      ? _questions[_currentQuestionIndex] 
      : null;
  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;

  // Methods
  void nextQuestion() {
    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void updateScore(Map<String, int> scoreUpdates) {
    scoreUpdates.forEach((attribute, value) {
      _scores[attribute] = (_scores[attribute] ?? 0) + value;
    });
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _scores = {
      'strength': 0,
      'intelligence': 0,
      'wisdom': 0,
      'dexterity': 0,
      'charisma': 0,
      'constitution': 0,
    };
    notifyListeners();
  }
}