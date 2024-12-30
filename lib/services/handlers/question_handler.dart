import '../../models/question.dart';

class QuestionHandler {
  static List<String> handleMultiSelect(List<String> currentAnswers, String option) {
    if (currentAnswers.contains(option)) {
      currentAnswers.remove(option);
    } else {
      currentAnswers.add(option);
    }
    return currentAnswers;
  }

  static bool canProceedWithQuestion(Question question, dynamic answer) {
    if (question.isMultipleChoice) {
      return (answer as List<String>?)?.isNotEmpty ?? false;
    }
    return answer != null;
  }

  static double getInitialScaleValue() => 4.0;
}