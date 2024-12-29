import 'package:flutter/material.dart';
import '../models/quiz_state.dart';

class QuizProvider extends ChangeNotifier {
  final QuizState _state;

  QuizProvider() : _state = QuizState();

  QuizState get state => _state;
  int get currentIndex => _state.currentIndex;
  Map<int, dynamic> get answers => _state.answers;
  bool get isComplete => _state.isComplete;

  void answerQuestion(dynamic answer) {
    final newAnswers = Map<int, dynamic>.from(_state.answers);
    if (currentIndex < newAnswers.length) {
      newAnswers[currentIndex] = answer;
    } else {
      newAnswers[currentIndex] = answer;
    }
    
    // Create new state
    _state = QuizState(
      answers: newAnswers,
      currentIndex: currentIndex + 1,
      isComplete: currentIndex + 1 >= totalQuestions,
    );
    
    notifyListeners();
  }

  // Helper getters and methods
  bool hasAnswer(int index) => _state.answers.containsKey(index);
  dynamic getAnswer(int index) => _state.answers[index];
  
  // You'll need to set this based on your questions list length
  int totalQuestions = 12;  // Default to 12 questions
}