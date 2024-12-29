import 'package:flutter/material.dart';
import '../models/quiz_state.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> questions;
  QuizState _state;
  
  QuizProvider({
    required this.questions,
  }) : _state = QuizState();

  QuizState get state => _state;
  int get currentIndex => _state.currentIndex;
  List<dynamic> get answers => _state.answers;
  bool get isComplete => _state.isComplete;

  void answerQuestion(dynamic answer) {
    final newAnswers = List<dynamic>.from(_state.answers);
    if (_state.currentIndex < newAnswers.length) {
      newAnswers[_state.currentIndex] = answer;
    } else {
      newAnswers.add(answer);
    }

    _state = _state.copyWith(
      answers: newAnswers,
      currentIndex: _state.currentIndex + 1,
      isComplete: _state.currentIndex + 1 >= questions.length,
    );
    notifyListeners();
  }

  void goBack() {
    if (_state.currentIndex > 0) {
      _state = _state.copyWith(
        currentIndex: _state.currentIndex - 1,
        isComplete: false,
      );
      notifyListeners();
    }
  }
}
