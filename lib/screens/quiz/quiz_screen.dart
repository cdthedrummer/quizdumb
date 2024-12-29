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
  final Map<int, List<String>> _answers = {};
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
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleOptionSelected(String option) {
    HapticFeedback.lightImpact();
    setState(() {
      final currentQuestion = widget.questions[_currentQuestionIndex];
      if (currentQuestion.type == 'single') {
        _answers[_currentQuestionIndex] = [option];
        debugPrint('Selected option: $option');
        
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
      } else {
        _answers[_currentQuestionIndex] = _answers[_currentQuestionIndex] ?? [];
        final currentAnswers = _answers[_currentQuestionIndex]!;
        if (currentAnswers.contains(option)) {
          currentAnswers.remove(option);
        } else {
          currentAnswers.add(option);
        }
        debugPrint('Updated answers: $_answers');
      }
    });
  }

  void _handleNext() {
    HapticFeedback.mediumImpact();
    if (_currentQuestionIndex < widget.questions.length - 1) {
      _animationController.forward();
      setState(() {
        _currentQuestionIndex++;
        debugPrint('Moving to next question');
      });
    } else {
      _showResults();
    }
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

    _answers.forEach((questionIndex, selectedOptions) {
      debugPrint('Processing question $questionIndex answers: $selectedOptions');
      final question = widget.questions[questionIndex];
      for (final option in selectedOptions) {
        final attributes = question.attributes[option]!;
        attributes.forEach((attribute, value) {
          scores[attribute] = (scores[attribute] ?? 3) + value;
          debugPrint('$attribute now at: ${scores[attribute]}');
        });
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
    final currentAnswers = _answers[_currentQuestionIndex] ?? [];

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
                    child: AnswerOptions(
                      question: currentQuestion,
                      selectedAnswers: currentAnswers,
                      onOptionSelected: _handleOptionSelected,
                    ),
                  ),
                ),
                
                if (currentQuestion.type == 'multiple')
                  NavigationButtons(
                    isLastQuestion: _currentQuestionIndex == widget.questions.length - 1,
                    hasAnswers: currentAnswers.isNotEmpty,
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