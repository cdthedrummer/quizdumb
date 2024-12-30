import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';
import '../models/result.dart';
import '../widgets/scale_question.dart';
import '../widgets/multiple_choice_question.dart';
import 'results_screen.dart';

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
  final Map<int, dynamic> _answers = {};
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
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

  void _handleScaleAnswer(double value) {
    HapticFeedback.lightImpact();
    setState(() {
      _answers[_currentQuestionIndex] = value;
      // Auto-advance after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_currentQuestionIndex < widget.questions.length - 1) {
          _goToNextQuestion();
        } else {
          _showResults();
        }
      });
    });
  }

  void _handleMultipleChoice(List<String> selectedOptions) {
    HapticFeedback.lightImpact();
    setState(() {
      _answers[_currentQuestionIndex] = selectedOptions;
    });
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      _animationController.forward();
      setState(() {
        _currentQuestionIndex++;
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

    _answers.forEach((questionIndex, answer) {
      final question = widget.questions[questionIndex];
      if (question.isScale) {
        final scaleValue = (answer as double).round();
        question.scaleAttributes?.forEach((attribute, baseValue) {
          scores[attribute] = (scores[attribute] ?? 3) + 
              (baseValue * ((scaleValue - 4) / 3)).round();
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

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(204),
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white.withAlpha(26),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / widget.questions.length,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withAlpha(179),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: currentQuestion.isScale
                        ? ScaleQuestion(
                            question: currentQuestion,
                            currentValue: (_answers[_currentQuestionIndex] as double?) ?? 4.0,
                            onChanged: _handleScaleAnswer,
                          )
                        : MultipleChoiceQuestion(
                            question: currentQuestion,
                            selectedOptions: (_answers[_currentQuestionIndex] as List<String>?) ?? [],
                            onChanged: _handleMultipleChoice,
                          ),
                  ),
                ),

                if (!currentQuestion.isScale)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (_answers[_currentQuestionIndex] as List<String>?)?.isNotEmpty == true 
                          ? 1.0 
                          : 0.7,
                      child: ElevatedButton(
                        onPressed: (_answers[_currentQuestionIndex] as List<String>?)?.isNotEmpty == true
                            ? _goToNextQuestion
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withAlpha(230),
                          foregroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _currentQuestionIndex == widget.questions.length - 1 
                            ? 'See Results' 
                            : 'Next',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
