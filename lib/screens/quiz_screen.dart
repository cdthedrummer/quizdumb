import 'package:flutter/material.dart';
import '../models/result.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, List<String>> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'text': 'How do you prefer to learn?',
      'options': ['Reading', 'Watching', 'Doing', 'Group'],
      'type': 'single',
      'attributes': {
        'Reading': {'Intelligence': 2, 'Wisdom': 1},
        'Watching': {'Wisdom': 2, 'Intelligence': 1},
        'Doing': {'Dexterity': 2, 'Strength': 1},
        'Group': {'Charisma': 2, 'Wisdom': 1},
      },
    },
    {
      'id': 2,
      'text': "Where's your focus when it comes to being healthy?",
      'options': ['Eating Well', 'Being Active', 'Relaxing', 'Regular Check-ups'],
      'type': 'multiple',
      'attributes': {
        'Eating Well': {'Constitution': 2},
        'Being Active': {'Strength': 1, 'Dexterity': 1},
        'Relaxing': {'Wisdom': 1},
        'Regular Check-ups': {'Constitution': 2},
      },
    },
    {
      'id': 3,
      'text': 'What kind of physical activity makes you the happiest?',
      'options': ['Outdoor Adventures', 'Team Sports', 'Solo Workouts', 'Fun Activities'],
      'type': 'single',
      'attributes': {
        'Outdoor Adventures': {'Constitution': 2, 'Wisdom': 1},
        'Team Sports': {'Charisma': 2, 'Dexterity': 1},
        'Solo Workouts': {'Strength': 2},
        'Fun Activities': {'Dexterity': 2, 'Charisma': 1},
      },
    },
  ];

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
      final question = _questions[questionIndex];
      for (final option in selectedOptions) {
        final attributes = question['attributes'][option] as Map<String, int>;
        attributes.forEach((attribute, value) {
          scores[attribute] = (scores[attribute] ?? 0) + value;
        });
      }
    });

    return QuizResult(scores: scores);
  }

  void _handleOptionSelected(String option) {
    setState(() {
      final currentQuestion = _questions[_currentQuestionIndex];
      if (currentQuestion['type'] == 'single') {
        _answers[_currentQuestionIndex] = [option];
        debugPrint('Selected option(s) for question ${_currentQuestionIndex + 1}: [$option]');
        
        // Auto-progress for single choice questions after a short delay
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_currentQuestionIndex < _questions.length - 1) {
            setState(() {
              _currentQuestionIndex++;
              debugPrint('Moving to question: ${_currentQuestionIndex + 1}');
            });
          } else {
            _showResults();
          }
        });
      } else {
        // Multiple choice handling
        _answers[_currentQuestionIndex] = _answers[_currentQuestionIndex] ?? [];
        final currentAnswers = _answers[_currentQuestionIndex]!;
        if (currentAnswers.contains(option)) {
          currentAnswers.remove(option);
        } else {
          currentAnswers.add(option);
        }
        debugPrint('Selected option(s) for question ${_currentQuestionIndex + 1}: $currentAnswers');
      }
    });
  }

  void _handleNext() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        debugPrint('Moving to question: ${_currentQuestionIndex + 1}');
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    debugPrint('Quiz complete!');
    final result = _calculateResults();
    debugPrint('Final scores: ${result.scores}');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final isMultipleChoice = currentQuestion['type'] == 'multiple';
    final currentAnswers = _answers[_currentQuestionIndex] ?? [];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(204), // 0.8 opacity
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Progress bar with container for visibility
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white.withAlpha(26), // 0.1 opacity
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / _questions.length,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withAlpha(179), // 0.7 opacity
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                Text(
                  currentQuestion['text'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                  textAlign: TextAlign.center,
                ),
                if (isMultipleChoice)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Select all that apply',
                      style: TextStyle(
                        color: Colors.white.withAlpha(204), // 0.8 opacity
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
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ElevatedButton(
                          onPressed: () => _handleOptionSelected(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected 
                                ? Colors.white.withAlpha(230) // 0.9 opacity
                                : Colors.white.withAlpha(51), // 0.2 opacity
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
                  ElevatedButton(
                    onPressed: currentAnswers.isNotEmpty ? _handleNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(230), // 0.9 opacity
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
                      _currentQuestionIndex == _questions.length - 1 
                        ? 'See Results' 
                        : 'Next',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
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