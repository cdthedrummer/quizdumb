import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/question.dart';
import '../../models/result.dart';
import '../../widgets/animated_gradient_container.dart';
import '../results/results_screen.dart';
import 'components/answer_options.dart';
import 'components/navigation_buttons.dart';
import 'components/progress_bar.dart';
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

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  bool _isAnimating = false;

  void _handleAnswerSelected(dynamic answer) {
    if (_isAnimating) return;

    HapticFeedback.lightImpact();
    setState(() {
      _answers[_currentIndex] = answer;
      
      // Auto-advance on single choice or scale questions
      if (widget.questions[_currentIndex].isSingleChoice || 
          widget.questions[_currentIndex].isScale) {
        _moveToNext();
      }
    });
  }

  void _moveToNext() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _isAnimating = true;
        _currentIndex++;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() => _isAnimating = false);
      });
    } else {
      _showResults();
    }
  }

  void _moveToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _isAnimating = true;
        _currentIndex--;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() => _isAnimating = false);
      });
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

    _answers.forEach((index, answer) {
      final question = widget.questions[index];
      scores.addAll(
        question.calculateScore(answer),
      );
    });

    // Ensure all scores are integers
    scores = scores.map((key, value) => 
      MapEntry(key, value.clamp(1, 20).toInt())
    );

    return QuizResult(scores: scores);
  }

  void _showResults() {
    final result = _calculateResults();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
          ResultsScreen(result: result),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve)
          );
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
    final currentQuestion = widget.questions[_currentIndex];
    final currentAnswer = _answers[_currentIndex];

    return Scaffold(
      body: AnimatedGradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProgressBar(
                  progress: (_currentIndex + 1) / widget.questions.length,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          currentQuestion.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Quicksand',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        if (currentQuestion.isScale)
                          ScaleSelector(
                            value: (currentAnswer as int?) ?? 0,
                            onChanged: _handleAnswerSelected,
                          )
                        else
                          AnswerOptions(
                            question: currentQuestion,
                            selectedAnswers: (currentAnswer as List<String>?) ?? [],
                            onOptionSelected: (option) => 
                              _handleAnswerSelected([option]),
                          ),
                      ],
                    ),
                  ),
                ),
                if (currentQuestion.isMultipleChoice)
                  NavigationButtons(
                    canGoBack: _currentIndex > 0,
                    isLastQuestion: _currentIndex == widget.questions.length - 1,
                    hasAnswers: currentAnswer != null && 
                      (currentAnswer as List<String>).isNotEmpty,
                    onNext: _moveToNext,
                    onBack: _moveToPrevious,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}