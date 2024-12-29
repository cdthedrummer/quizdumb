import 'package:flutter/foundation.dart';
import 'question.dart';
import 'result.dart';

class QuizState extends ChangeNotifier {
  final List<Question> questions;
  final Map<int, List<String>> answers = {};
  int currentQuestionIndex = 0;

  QuizState({required this.questions}) {
    debugPrint('Initializing QuizState with ${questions.length} questions');
  }

  Question get currentQuestion => questions[currentQuestionIndex];
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;
  double get progress => (currentQuestionIndex + 1) / questions.length;
  List<String> get currentAnswers => answers[currentQuestionIndex] ?? [];

  void selectOption(String option) {
    debugPrint('Selected option: $option');
    if (currentQuestion.isMultipleChoice) {
      answers[currentQuestionIndex] = answers[currentQuestionIndex] ?? [];
      final currentAnswers = answers[currentQuestionIndex]!;
      if (currentAnswers.contains(option)) {
        currentAnswers.remove(option);
      } else {
        currentAnswers.add(option);
      }
    } else {
      answers[currentQuestionIndex] = [option];
    }
    debugPrint('Current answers: ${answers[currentQuestionIndex]}');
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      debugPrint('Moving to question ${currentQuestionIndex + 1}');
      notifyListeners();
    }
  }

  QuizResult calculateResults() {
    Map<String, int> scores = {
      'Strength': 3,
      'Dexterity': 3,
      'Constitution': 3,
      'Intelligence': 3,
      'Wisdom': 3,
      'Charisma': 3,
    };

    debugPrint('Starting with base scores: $scores');

    answers.forEach((questionIndex, selectedOptions) {
      debugPrint('\nProcessing question ${questionIndex + 1}:');
      final question = questions[questionIndex];
      for (final option in selectedOptions) {
        final attributes = question.attributes[option]!;
        debugPrint('  Selected option "$option" adds: $attributes');
        attributes.forEach((attribute, value) {
          scores[attribute] = (scores[attribute] ?? 3) + value;
          debugPrint('    $attribute now at: ${scores[attribute]}');
        });
      }
    });

    debugPrint('Final scores: $scores');
    return QuizResult(scores: scores);
  }
}