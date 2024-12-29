import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/question.dart';
import '../../widgets/animated_gradient_container.dart';
import '../results/results_screen.dart';
import '../../models/result.dart';
import 'components/progress_bar.dart';
import 'components/question_card.dart';
import 'components/answer_options.dart';
import 'components/navigation_buttons.dart';
import 'components/scale_selector.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;

  const QuizScreen({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  final Map<int, dynamic> _answers = {};  // Can store List<String> or int
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    debugPrint('Initializing QuizScreen');
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _animationController.addListener(_handleAnimationComplete);
  }

  void _handleAnimationComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleScaleSelected(int value) {
    HapticFeedback.lightImpact();
    setState(() {
      _answers[_currentQuestionIndex] = value;
      _moveToNextQuestion();
    });
  }

  void _handleOptionSelected(String option) {
    HapticFeedback.lightImpact();
    setState(() {
      final currentQuestion = widget.questions[_currentQuestionIndex];
      if (currentQuestion.isSingleChoice) {
        _answers[_currentQuestionIndex] = [option];
        _moveToNextQuestion();
      } else {
        final currentAnswers = (_answers[_currentQuestionIndex] as List<String>?) ?? [];
        if (currentAnswers.contains(option)) {
          currentAnswers.remove(option);
        } else {
          currentAnswers.add(option);
        }
        _answers[_currentQuestionIndex] = currentAnswers;
        debugPrint('Updated answers: $_answers');
      }
    });
  }

  void _moveToNextQuestion() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _animationController.forward();
        setState(() {
          _currentQuestionIndex++;
          debugPrint('Moving to next question');
        });
      } else {
        _showResults();
      }
    });
  }

  void _handleNext() {
    HapticFeedback.mediumImpact();
    _moveToNextQuestion();
  }

  QuizResult _calculateResults() {
    Map<String, int> scores = {
      'Strength': 3,
      'Dexterity': 3,
      'Constitution': 3,
      'Intelligence': 3,
      'Wisdom': 3,
      'Charisma': 3,
    };

    debugPrint('Starting with base scores: $scores');

    _answers.forEach((questionIndex, answer) {
      final question = widget.questions[questionIndex];
      
      if (question.isScale) {
        final scaleValue = answer as int;
        question.scaleAttributes?.forEach((attribute, baseValue) {
          scores[attribute] = (scores[attribute] ?? 3) + (baseValue * scaleValue);
        });
      } else {
        final selectedOptions = answer as List<String>;
        for (final option in selectedOptions) {
          question.attributes?[option]?.forEach((attribute, value) {
            scores[attribute] = (scores[attribute] ?? 3) + value;
          });
        }
      }
    });

    debugPrint('Final scores: $scores');
    return QuizResult(scores: scores);
  }

  void _showResults() {
    debugPrint('Calculating results');
    final result = _calculateResults();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ResultsScreen(result: result),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentQuestionIndex];
    final currentAnswer = _answers[_currentQuestionIndex];

    return Scaffold(
      body: AnimatedGradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                QuizProgressBar(progress: (_currentQuestionIndex + 1) / widget.questions.length),
                const SizedBox(height: 20),
                
                QuestionCard(
                  question: currentQuestion,
                  fadeAnimation: _fadeAnimation,
                ),
                const SizedBox(height: 40),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: currentQuestion.isScale
                        ? ScaleSelector(
                            value: (currentAnswer as int?) ?? 0,
                            onChanged: _handleScaleSelected,
                          )
                        : AnswerOptions(
                            question: currentQuestion,
                            selectedAnswers: (currentAnswer as List<String>?) ?? [],
                            onOptionSelected: _handleOptionSelected,
                          ),
                  ),
                ),
                
                if (currentQuestion.isMultipleChoice)
                  NavigationButtons(
                    isLastQuestion: _currentQuestionIndex == widget.questions.length - 1,
                    hasAnswers: currentAnswer != null && (currentAnswer as List<String>).isNotEmpty,
                    onNext: _handleNext,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}