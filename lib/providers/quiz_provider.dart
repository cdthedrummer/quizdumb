import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../models/result.dart';
import '../data/questions.dart';

class QuizProvider with ChangeNotifier {
  QuizStatus _status = QuizStatus.initial;
  int _currentQuestionIndex = 0;
  final List<Question> _questions = quizQuestions;
  final Map<int, List<String>> _answers = {};
  final Map<String, int> _scores = {
    'Strength': 0,
    'Intelligence': 0,
    'Wisdom': 0,
    'Dexterity': 0,
    'Charisma': 0,
    'Constitution': 0,
  };

  // Getters
  QuizStatus get status => _status;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<Question> get questions => List.unmodifiable(_questions);
  Question get currentQuestion => _questions[_currentQuestionIndex];
  Map<String, int> get scores => Map.unmodifiable(_scores);
  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;
  double get progress => (_currentQuestionIndex + 1) / _questions.length;

  // Answer Management
  void answerQuestion(int questionId, dynamic answer) {
    final question = _questions.firstWhere((q) => q.id == questionId);
    List<String> answerList;

    if (answer is int) {
      answerList = [answer.toString()];
      _handleScaleAnswer(question, answer);
    } else if (answer is List<String>) {
      answerList = answer;
      _handleChoiceAnswer(question, answer);
    } else {
      answerList = [answer.toString()];
    }

    _answers[questionId] = answerList;
    notifyListeners();
  }

  List<String>? getAnswerForQuestion(int questionId) => _answers[questionId];

  void _handleScaleAnswer(Question question, int value) {
    question.scaleAttributes?.forEach((attribute, weight) {
      _scores[attribute] = (_scores[attribute] ?? 0) + (weight * value ~/ 7);
    });
  }

  void _handleChoiceAnswer(Question question, List<String> selectedOptions) {
    for (final option in selectedOptions) {
      final attributes = question.attributes?[option] ?? {};
      for (final entry in attributes.entries) {
        _scores[entry.key] = (_scores[entry.key] ?? 0) + entry.value;
      }
    }
  }

  // Navigation
  void nextQuestion() {
    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
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

  // Quiz State Management
  void startQuiz() {
    _status = QuizStatus.inProgress;
    _currentQuestionIndex = 0;
    _answers.clear();
    _resetScores();
    notifyListeners();
  }

  void resetQuiz() {
    _status = QuizStatus.initial;
    _currentQuestionIndex = 0;
    _answers.clear();
    _resetScores();
    notifyListeners();
  }

  void _resetScores() {
    _scores.updateAll((key, value) => 0);
  }

  // Results Calculation
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

  QuizResult getResults() {
    return QuizResult(
      scores: Map.from(_scores),
      primaryAttribute: getPrimaryAttribute() ?? '',
      totalQuestions: _questions.length,
      answeredQuestions: _answers.length,
    );
  }
}

enum QuizStatus { initial, inProgress, complete }