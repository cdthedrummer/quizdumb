import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/question.dart';
import '../../providers/quiz_provider.dart';
import 'components/multiple_choice_question.dart';
import 'components/scale_question.dart';
import 'components/navigation_buttons.dart';
import 'components/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final question = quizProvider.currentQuestion;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProgressBar(progress: quizProvider.progress),
                  const SizedBox(height: 24),
                  Text(
                    question.text,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: _buildQuestionWidget(
                      question,
                      quizProvider,
                    ),
                  ),
                  NavigationButtons(
                    onPrevious: quizProvider.currentQuestionIndex > 0
                        ? () => quizProvider.previousQuestion()
                        : null,
                    onNext: () => quizProvider.nextQuestion(),
                    showNext: _canMoveNext(quizProvider),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionWidget(Question question, QuizProvider provider) {
    if (question.isScale) {
      return ScaleQuestion(
        labels: question.scaleLabels!,
        value: provider.getAnswerForQuestion(question.id)?.first != null
            ? int.parse(provider.getAnswerForQuestion(question.id)!.first)
            : 4,
        onChanged: (value) => provider.answerQuestion(question.id, value),
      );
    }

    return MultipleChoiceQuestion(
      options: question.options!,
      isMultiSelect: question.isMultipleChoice,
      selectedAnswers: provider.getAnswerForQuestion(question.id) ?? [],
      onAnswerSelected: (answers) => provider.answerQuestion(question.id, answers),
    );
  }

  bool _canMoveNext(QuizProvider provider) {
    final currentQuestionId = provider.currentQuestion.id;
    return provider.getAnswerForQuestion(currentQuestionId) != null;
  }
}