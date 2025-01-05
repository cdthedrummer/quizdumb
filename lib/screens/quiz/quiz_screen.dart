import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/question.dart';
import '../../providers/quiz_provider.dart';
import '../results/results_screen.dart';
import 'components/multiple_choice_question.dart';
import 'components/scale_question.dart';
import 'components/navigation_buttons.dart';
import 'components/progress_bar.dart';
import 'components/sparkle_overlay.dart';
import 'components/success_burst.dart';
import '../../widgets/animated_background.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  
  // Visual effect states
  bool _showSparkles = false;
  bool _showBurst = false;
  bool _isScaleInteracting = false;
  Offset? _burstPoint;

  // Gradient colors for progress indication
  final List<List<Color>> _gradientSets = [
    [const Color(0xFF9575CD), const Color(0xFF5E35B1)], // Initial purple
    [const Color(0xFF81C784), const Color(0xFF2E7D32)], // Mid green
    [const Color(0xFF64B5F6), const Color(0xFF1565C0)], // Final blue
  ];

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

  List<Color> _getGradientColors(double progress) {
    final index = (progress * (_gradientSets.length - 1)).floor();
    final nextIndex = (index + 1).clamp(0, _gradientSets.length - 1);
    final localProgress = (progress * (_gradientSets.length - 1)) - index;
    
    return [
      Color.lerp(_gradientSets[index][0], _gradientSets[nextIndex][0], localProgress) ?? _gradientSets[0][0],
      Color.lerp(_gradientSets[index][1], _gradientSets[nextIndex][1], localProgress) ?? _gradientSets[0][1],
    ];
  }

  void _handleAnswerSelection(BuildContext context, Question question, dynamic answer, {Offset? answerPosition}) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final previousAnswer = quizProvider.getAnswerForQuestion(question.id);
    quizProvider.answerQuestion(question.id, answer);
    
    // Show effects only for non-scale questions and final selections
    if (!question.isScale && 
        (!question.isMultipleChoice || 
         (previousAnswer?.length ?? 0) < (answer as List).length)) {
      setState(() {
        _showSparkles = true;
        _showBurst = true;
        _burstPoint = answerPosition;
      });
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _showSparkles = false;
            _showBurst = false;
            _burstPoint = null;
          });
        }
      });

      // Auto-advance for single choice questions
      if (!question.isMultipleChoice) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            quizProvider.nextQuestion();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final question = quizProvider.currentQuestion;
        final currentProgress = quizProvider.progress;
        final currentColors = _getGradientColors(currentProgress);

        // Handle quiz completion
        if (quizProvider.status == QuizStatus.complete) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ResultsScreen(),
              ),
            );
          });
        }

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: AnimatedBackground(
              colors: currentColors,
              isEnabled: !_isScaleInteracting,
              child: Material(
                type: MaterialType.transparency,
                child: SparkleOverlay(
                  triggerEffect: _showSparkles,
                  child: SuccessBurst(
                    trigger: _showBurst,
                    burstPoint: _burstPoint,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProgressBar(progress: currentProgress),
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
        onChanged: (value) {
          setState(() => _isScaleInteracting = true);
          _handleAnswerSelection(context, question, value);
        },
        onInteractionEnd: () {
          setState(() => _isScaleInteracting = false);
        },
      );
    }

    return MultipleChoiceQuestion(
      options: question.options!,
      isMultiSelect: question.isMultipleChoice,
      selectedAnswers: provider.getAnswerForQuestion(question.id) ?? [],
      onAnswerSelected: (answers, position) => 
          _handleAnswerSelection(context, question, answers, answerPosition: position),
    );
  }

  bool _canMoveNext(QuizProvider provider) {
    final currentQuestionId = provider.currentQuestion.id;
    return provider.getAnswerForQuestion(currentQuestionId) != null;
  }
}