import 'package:flutter/material.dart';
import '../models/quiz_state.dart';

class QuizProvider extends ChangeNotifier {
  QuizState _state;  // Removed final to allow state updates
  final int totalQuestions;

  QuizProvider({this.totalQuestions = 12}) : _state = QuizState();

  QuizState get state => _state;
  int get currentIndex => _state.currentIndex;
  Map<int, dynamic> get answers => _state.answers;
  bool get isComplete => _state.isComplete;

  void answerQuestion(dynamic answer) {
    final newAnswers = Map<int, dynamic>.from(_state.answers);
    newAnswers[_state.currentIndex] = answer;
    
    _state = QuizState(
      answers: newAnswers,
      currentIndex: _state.currentIndex + 1,
      isComplete: _state.currentIndex + 1 >= totalQuestions,
    );
    
    notifyListeners();
  }

  void goBack() {
    if (_state.currentIndex > 0) {
      _state = QuizState(
        answers: _state.answers,
        currentIndex: _state.currentIndex - 1,
        isComplete: false,
      );
      notifyListeners();
    }
  }

  bool hasAnswer(int index) => _state.answers.containsKey(index);
  dynamic getAnswer(int index) => _state.answers[index];
}