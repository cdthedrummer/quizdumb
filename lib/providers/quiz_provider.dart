import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final List<Question> _questions = [];
  final Map<int, List<int>> _answers = {};
  final Map<String, double> _scores = {
    'strength': 0,
    'dexterity': 0,
    'constitution': 0,
    'intelligence': 0,
    'wisdom': 0,
    'charisma': 0,
  };

  int get currentIndex => _currentIndex;
  List<Question> get questions => List.unmodifiable(_questions);
  Map<String, double> get scores => Map.unmodifiable(_scores);
  double get progress => _questions.isEmpty ? 0 : (_currentIndex + 1) / _questions.length;
  bool get isComplete => _currentIndex >= _questions.length;

  void answerQuestion(List<int> selectedIndices) {
    if (kDebugMode) {
      print('Answering question $_currentIndex with $selectedIndices');
    }
    
    _answers[_currentIndex] = selectedIndices;
    _updateScores();
    
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void _updateScores() {
    // Reset scores
    _scores.updateAll((key, value) => 0);
    
    // Calculate new scores
    _answers.forEach((questionIndex, answerIndices) {
      final question = _questions[questionIndex];
      answerIndices.forEach((answerIndex) {
        question.attributeScores.forEach((attribute, scores) {
          _scores[attribute] = (_scores[attribute] ?? 0) + scores[answerIndex];
        });
      });
    });

    if (kDebugMode) {
      print('Updated scores: $_scores');
    }
  }

  void reset() {
    _currentIndex = 0;
    _answers.clear();
    _updateScores();
    notifyListeners();
  }
}
