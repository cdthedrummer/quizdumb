import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/question.dart';
import '../../providers/quiz_provider.dart';
import '../results/results_screen.dart';
import 'components/multiple_choice_question.dart';
import 'components/scale_question.dart';
import 'components/navigation_buttons.dart';
import 'components/progress_bar.dart';
import 'components/question_card_base.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final question = quizProvider.currentQuestion;
        
        if (quizProvider.status == QuizStatus.complete) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ResultsScreen(),
              ),
            );
          });
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProgressBar(progress: quizProvider.progress),
                    const SizedBox(height: 32),
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: QuestionCardBase(
                          question: question,
                          child: _buildQuestionContent(
                            question,
                            quizProvider,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
          ),
        );
      },
    );
  }

  Widget _buildQuestionContent(Question question, QuizProvider provider) {
    if (question.isScale) {
      return ScaleQuestion(
        labels: question.scaleLabels!,
        value: provider.getAnswerForQuestion(question.id)?.first != null
            ? int.parse(provider.getAnswerForQuestion(question.id)!.first)
            : 4,
        onChanged: (value) {
          setState(() => _isInteracting = true);
          _handleAnswerSelection(question, [value.toString()], null);
        },
        onInteractionEnd: () {
          setState(() => _isInteracting = false);
        },
      );
    }

    return MultipleChoiceQuestion(
      options: question.options!,
      isMultiSelect: question.isMultipleChoice,
      selectedAnswers: provider.getAnswerForQuestion(question.id) ?? [],
      onAnswerSelected: (answers, position) => 
          _handleAnswerSelection(question, answers, position),
    );
  }

  void _handleAnswerSelection(Question question, List<String> answers, Offset? position) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    provider.answerQuestion(question.id, answers);

    if (!question.isScale && !question.isMultipleChoice) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          provider.nextQuestion();
        }
      });
    }
  }

  bool _canMoveNext(QuizProvider provider) {
    final currentQuestionId = provider.currentQuestion.id;
    return provider.getAnswerForQuestion(currentQuestionId) != null;
  }
}