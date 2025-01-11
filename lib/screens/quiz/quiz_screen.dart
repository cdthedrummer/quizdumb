import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/question.dart';
import '../../providers/quiz_provider.dart';
import '../results/results_screen.dart';
import 'components/multiple_choice_question.dart';
import 'components/scale_question.dart';
import 'components/navigation_buttons.dart';
import 'components/progress_bar.dart';
import 'checkpoint_screen.dart';

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

  Widget _buildQuizContent(QuizProvider provider) {
    final question = provider.currentQuestion;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withAlpha(50),
                  Theme.of(context).colorScheme.secondary.withAlpha(30),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProgressBar(progress: provider.progress),
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
                      onPrevious: provider.currentQuestionIndex > 0
                          ? () => provider.previousQuestion()
                          : null,
                      onNext: () => provider.nextQuestion(),
                      showNext: _canMoveNext(provider),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
