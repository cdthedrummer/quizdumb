import 'package:flutter/foundation.dart';
import '../data/questions.dart';
import '../models/question.dart';

enum QuizStatus { initial, inProgress, complete }

class QuizProvider with ChangeNotifier {
  // State variables
  QuizStatus _status = QuizStatus.initial;
  int _currentQuestionIndex = 0;
  final List<Question> _questions = quizQuestions;
  final Map<String, int> _scores = {
    'Strength': 0,
    'Intelligence': 0,
    'Wisdom': 0,
    'Dexterity': 0,
    'Charisma': 0,
    'Constitution': 0,
  };
  final Map<int, List<String>> _answers = {};

  // Getters
  QuizStatus get status => _status;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<Question> get questions => _questions;
  Map<String, int> get scores => Map.unmodifiable(_scores);
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;
  double get progress => (_currentQuestionIndex + 1) / _questions.length;
  List<String>? getAnswersForQuestion(int questionId) => _answers[questionId];

  // Methods
  void startQuiz() {
    _status = QuizStatus.inProgress;
    _currentQuestionIndex = 0;
    _scores.updateAll((key, value) => 0);
    _answers.clear();
    notifyListeners();
  }

  void answerQuestion(int questionId, dynamic answer) {
    Question question = _questions.firstWhere((q) => q.id == questionId);
    
    if (question.type == 'scale') {
      _handleScaleAnswer(question, answer as int);
    } else {
      _handleChoiceAnswer(question, answer as List<String>);
    }
    
    _answers[questionId] = answer is List ? answer : [answer.toString()];
    notifyListeners();
  }

  void _handleScaleAnswer(Question question, int value) {
    question.scaleAttributes?.forEach((attribute, weight) {
      _scores[attribute] = (_scores[attribute] ?? 0) + (weight * value ~/ 7);
    });
  }

  void _handleChoiceAnswer(Question question, List<String> selectedOptions) {
    selectedOptions.forEach((option) {
      final attributes = question.attributes?[option] ?? {};
      attributes.forEach((attribute, value) {
        _scores[attribute] = (_scores[attribute] ?? 0) + value;
      });
    });
  }

  void nextQuestion() {
    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    } else if (_currentQuestionIndex == _questions.length - 1) {
      _status = QuizStatus.complete;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _status = QuizStatus.initial;
    _currentQuestionIndex = 0;
    _scores.updateAll((key, value) => 0);
    _answers.clear();
    notifyListeners();
  }

  String? getPrimaryAttribute() {
    if (_scores.isEmpty) return null;
    return _scores.entries
        .reduce((max, entry) => entry.value > max.value ? entry : max)
        .key;
  }

  Map<String, int> getAttributeRankings() {
    var sortedEntries = _scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sortedEntries);
  }
}