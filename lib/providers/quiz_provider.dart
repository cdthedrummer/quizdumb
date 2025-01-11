import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences.dart';
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
  String? _currentCheckpointMessage;

  QuizStatus get status => _status;
  int get currentQuestionIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  double get progress => _currentIndex / (_questions.length - 1);
  Map<String, double> get scores => calculateScores();
  bool get isLoading => _isLoading;
  String? get currentCheckpointMessage => _currentCheckpointMessage;

  // Get encouraging message based on progress
  String getEncouragingMessage() {
    final currentProgress = progress * 100;
    if (currentProgress < 33) {
      return 'Great start! Keep going, you\'re doing great! 🌟';
    } else if (currentProgress < 66) {
      return 'Halfway there! Your journey is shaping up nicely! ⚔️';
    } else {
      return 'Almost there! You\'re on the path to greatness! 🏆';
    }
  }

  // Check if current question is a checkpoint
  bool get isAtCheckpoint {
    if (_currentIndex >= _questions.length) return false;
    return currentQuestion.isCheckpoint;
  }

  void startQuiz() {
    _status = QuizStatus.inProgress;
    _currentIndex = 0;
    _answers.clear();
    _isLoading = false;
    _currentCheckpointMessage = null;
    notifyListeners();
    saveProgress();
  }

  void resetQuiz() {
    _status = QuizStatus.notStarted;
    _currentIndex = 0;
    _answers.clear();
    _isLoading = false;
    _currentCheckpointMessage = null;
    notifyListeners();
    saveProgress();
  }

  Future<void> nextQuestion() async {
    if (_isLoading) return;
    
    if (_currentIndex < _questions.length - 1) {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 100));
      
      // Check if next question is a checkpoint
      if (_questions[_currentIndex + 1].isCheckpoint) {
        _status = QuizStatus.checkpoint;
        _currentCheckpointMessage = _questions[_currentIndex + 1].encouragingMessage;
      }
      
      _currentIndex++;
      _isLoading = false;
      notifyListeners();
      saveProgress();
    } else {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 100));
      _status = QuizStatus.complete;
      _isLoading = false;
      notifyListeners();
      saveProgress();
    }
  }

  Future<void> previousQuestion() async {
    if (_isLoading || _currentIndex <= 0) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));
    _currentIndex--;
    
    // Update status if moving back from a checkpoint
    if (_status == QuizStatus.checkpoint && !currentQuestion.isCheckpoint) {
      _status = QuizStatus.inProgress;
      _currentCheckpointMessage = null;
    }
    
    _isLoading = false;
    notifyListeners();
    saveProgress();
  }

  List<String>? getAnswerForQuestion(String questionId) {
    return _answers[questionId];
  }

  void answerQuestion(String questionId, List<String> answer) {
    _answers[questionId] = answer;
    notifyListeners();
    saveProgress();
  }

  // Save progress to local storage
  Future<void> saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progress = {
        'currentIndex': _currentIndex,
        'status': _status.index,
        'answers': _answers,
      };
      await prefs.setString('quiz_progress', jsonEncode(progress));
    } catch (e) {
      debugPrint('Error saving progress: $e');
    }
  }

  // Load progress from local storage
  Future<void> loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedProgress = prefs.getString('quiz_progress');
      
      if (savedProgress != null) {
        final progress = jsonDecode(savedProgress);
        _currentIndex = progress['currentIndex'] ?? 0;
        _status = QuizStatus.values[progress['status'] ?? 0];
        _answers.clear();
        _answers.addAll(Map<String, List<String>>.from(progress['answers'] ?? {}));
        
        if (_currentIndex < _questions.length && _questions[_currentIndex].isCheckpoint) {
          _currentCheckpointMessage = _questions[_currentIndex].encouragingMessage;
        }
        
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading progress: $e');
    }
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

      // Normalize scores
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