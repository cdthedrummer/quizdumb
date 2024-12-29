import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/result.dart';
import '../data/questions.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

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
      final currentQuestion = quizQuestions[_currentQuestionIndex];
      if (currentQuestion['type'] == 'single') {
        _answers[_currentQuestionIndex] = [option];
        debugPrint('Selected option for question ${_currentQuestionIndex + 1}: $option');
        
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_currentQuestionIndex < quizQuestions.length - 1) {
            _animationController.forward();
            setState(() {
              _currentQuestionIndex++;
              debugPrint('Moving to question ${_currentQuestionIndex + 1}');
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
        debugPrint('Updated multiple choice answers: $currentAnswers');
      }
    });
  }

  void _handleNext() {
    HapticFeedback.mediumImpact();
    if (_currentQuestionIndex < quizQuestions.length - 1) {
      _animationController.forward();
      setState(() {
        _currentQuestionIndex++;
        debugPrint('Moving to next question: ${_currentQuestionIndex + 1}');
      });
    } else {
      _showResults();
    }
  }

  QuizResult _calculateResults() {
    Map<String, int> scores = {
      'Strength': 0,
      'Dexterity': 0,
      'Constitution': 0,
      'Intelligence': 0,
      'Wisdom': 0,
      'Charisma': 0,
    };

    _answers.forEach((questionIndex, selectedOptions) {
      for (final option in selectedOptions) {
        final attributes = quizQuestions[questionIndex]['attributes'][option] as Map<String, int>;
        attributes.forEach((attribute, value) {
          scores[attribute] = (scores[attribute] ?? 0) + value;
        });
      }
    });

    debugPrint('Final scores calculated: $scores');
    return QuizResult(scores: scores);
  }

  void _showResults() {
    debugPrint('Quiz completed, showing results');
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
    final currentQuestion = quizQuestions[_currentQuestionIndex];
    final isMultipleChoice = currentQuestion['type'] == 'multiple';
    final currentAnswers = _answers[_currentQuestionIndex] ?? [];

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
                      value: (_currentQuestionIndex + 1) / quizQuestions.length,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withAlpha(179),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    currentQuestion['text'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                if (isMultipleChoice)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Select all that apply',
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
                
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuestion['options'].length,
                    itemBuilder: (context, index) {
                      final option = currentQuestion['options'][index];
                      final isSelected = isMultipleChoice 
                          ? currentAnswers.contains(option)
                          : currentAnswers.firstOrNull == option;
                      
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.only(
                          bottom: 12.0,
                          left: isSelected ? 8.0 : 0.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () => _handleOptionSelected(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected 
                                ? Colors.white.withAlpha(230)
                                : Colors.white.withAlpha(51),
                            foregroundColor: isSelected ? Colors.purple : Colors.white,
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                if (isMultipleChoice)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: currentAnswers.isNotEmpty ? 1.0 : 0.7,
                    child: ElevatedButton(
                      onPressed: currentAnswers.isNotEmpty ? _handleNext : null,
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
                        _currentQuestionIndex == quizQuestions.length - 1 
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}