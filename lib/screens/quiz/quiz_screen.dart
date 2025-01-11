import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/question.dart';
import '../../providers/quiz_provider.dart';
import '../results/results_screen.dart';
import 'components/multiple_choice_question.dart';
import 'components/scale_question.dart';
import 'components/navigation_buttons.dart';
import 'components/progress_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

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

  void _navigateToResults() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResultsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop) async {
        Provider.of<QuizProvider>(context, listen: false).resetQuiz();
        return true;
      },
      child: Consumer<QuizProvider>(
        builder: (context, quizProvider, _) {
          final question = quizProvider.currentQuestion;
          
          if (quizProvider.status == QuizStatus.complete) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateToResults();
            });
          }

          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor.withAlpha(204),
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
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight - 200,
                                ),
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: _buildQuestionContent(question),
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
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestionContent(Question question) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    final currentAnswer = provider.getAnswerForQuestion(question.id);
    
    if (question.isScale) {
      final scaleValue = currentAnswer?.isNotEmpty == true 
          ? int.tryParse(currentAnswer!.first) ?? 4 
          : 4;
          
      return ScaleQuestion(
        labels: question.scaleLabels!,
        value: scaleValue,
        onChanged: (value) {
          provider.answerQuestion(question.id, [value.toString()]);
        },
      );
    }

    return MultipleChoiceQuestion(
      options: question.options!,
      isMultiSelect: question.isMultipleChoice,
      selectedAnswers: currentAnswer ?? [],
      onAnswerSelected: (answers, _) {
        provider.answerQuestion(question.id, answers);
        
        if (!question.isMultipleChoice) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              provider.nextQuestion();
            }
          });
        }
      },
    );
  }

  bool _canMoveNext(QuizProvider provider) {
    final currentQuestionId = provider.currentQuestion.id;
    return provider.getAnswerForQuestion(currentQuestionId) != null;
  }
}