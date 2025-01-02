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
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  
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

  void _handleAnswerSelection(BuildContext context, Question question, dynamic answer) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.answerQuestion(question.id, answer);
    
    // Auto-progress for single-select questions
    if (!question.isMultipleChoice && !question.isScale) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          quizProvider.nextQuestion();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final question = quizProvider.currentQuestion;

        // Check if quiz is complete and navigate to results
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF9575CD), // Light purple
                  Color(0xFF5E35B1), // Dark purple
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProgressBar(progress: quizProvider.progress),
                      const SizedBox(height: 24),
                      Text(
                        question.text,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                        ),
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
        onChanged: (value) => _handleAnswerSelection(context, question, value),
      );
    }

    return MultipleChoiceQuestion(
      options: question.options!,
      isMultiSelect: question.isMultipleChoice,
      selectedAnswers: provider.getAnswerForQuestion(question.id) ?? [],
      onAnswerSelected: (answers) => _handleAnswerSelection(context, question, answers),
    );
  }

  bool _canMoveNext(QuizProvider provider) {
    final currentQuestionId = provider.currentQuestion.id;
    return provider.getAnswerForQuestion(currentQuestionId) != null;
  }
}