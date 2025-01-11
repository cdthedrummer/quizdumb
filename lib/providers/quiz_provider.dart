import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../data/questions.dart';

enum QuizStatus {
  notStarted,
  inProgress,
  checkpoint,
  complete,
}

class QuizProvider with ChangeNotifier {
  int _currentIndex = 0;
  final Map<String, List<String>> _answers = {};
  QuizStatus _status = QuizStatus.notStarted;
  final List<Question> _questions = questions;
  bool _isLoading = false;
  String? _checkpointMessage;

  QuizStatus get status => _status;
  int get currentQuestionIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  double get progress => _currentIndex / (_questions.length - 1);
  Map<String, double> get scores => calculateScores();
  bool get isLoading => _isLoading;
  String? get checkpointMessage => _checkpointMessage;

  String getProgressMessage() {
    final percent = progress * 100;
    if (percent < 33) return 'You\'re off to a great start! 🌟';
    if (percent < 66) return 'Halfway there! Keep going! ⚔️';
    return 'Almost there! The finish line is in sight! 🏆';
  }

  void startQuiz() {
    _status = QuizStatus.inProgress;
    _currentIndex = 0;
    _answers.clear();
    _isLoading = false;
    _checkpointMessage = null;
    notifyListeners();
  }

  void resetQuiz() {
    _status = QuizStatus.notStarted;
    _currentIndex = 0;
    _answers.clear();
    _isLoading = false;
    _checkpointMessage = null;
    notifyListeners();
  }

  Future<void> nextQuestion() async {
    if (_isLoading) return;
    
    if (_currentIndex < _questions.length - 1) {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 100));
      
      // Check for checkpoint
      final nextQuestion = _questions[_currentIndex + 1];
      if (nextQuestion.isCheckpoint) {
        _status = QuizStatus.checkpoint;
        _checkpointMessage = nextQuestion.encouragingMessage;
      } else {
        _status = QuizStatus.inProgress;
      }
      
      _currentIndex++;
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 100));
      _status = QuizStatus.complete;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> previousQuestion() async {
    if (_isLoading || _currentIndex <= 0) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));
    _currentIndex--;
    _status = QuizStatus.inProgress;
    _checkpointMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  List<String>? getAnswerForQuestion(String questionId) {
    return _answers[questionId];
  }

  void answerQuestion(String questionId, List<String> answer) {
    _answers[questionId] = answer;
    notifyListeners();
  }

  Map<String, double> calculateScores() {
    try {
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

      final normalizedScores = <String, double>{};
      scores.forEach((key, value) {
        final total = totals[key] ?? 1;
        normalizedScores[key] = (value / total).clamp(0.0, 1.0);
      });

      return normalizedScores;
    } catch (e) {
      debugPrint('Error calculating scores: $e');
      return {};
    }
  }
}