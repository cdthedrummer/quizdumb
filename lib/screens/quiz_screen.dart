import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  Map<int, List<String>> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'text': 'How do you prefer to learn?',
      'options': ['Reading', 'Watching', 'Doing', 'Group'],
      'type': 'single',
      'attributes': {
        'Reading': {'intelligence': 2, 'wisdom': 1},
        'Watching': {'wisdom': 2, 'intelligence': 1},
        'Doing': {'dexterity': 2, 'strength': 1},
        'Group': {'charisma': 2, 'wisdom': 1},
      },
    },
    {
      'id': 2,
      'text': 'Where\'s your focus when it comes to being healthy?',
      'options': ['Eating Well', 'Being Active', 'Relaxing', 'Regular Check-ups'],
      'type': 'multiple',
      'attributes': {
        'Eating Well': {'constitution': 2},
        'Being Active': {'strength': 1, 'dexterity': 1},
        'Relaxing': {'wisdom': 1},
        'Regular Check-ups': {'constitution': 2},
      },
    },
    {
      'id': 3,
      'text': 'What kind of physical activity makes you the happiest?',
      'options': ['Outdoor Adventures', 'Team Sports', 'Solo Workouts', 'Fun Activities'],
      'type': 'single',
      'attributes': {
        'Outdoor Adventures': {'constitution': 2, 'wisdom': 1},
        'Team Sports': {'charisma': 2, 'dexterity': 1},
        'Solo Workouts': {'strength': 2},
        'Fun Activities': {'dexterity': 2, 'charisma': 1},
      },
    },
  ];

  void _handleOptionSelected(String option) {
    setState(() {
      final currentQuestion = _questions[_currentQuestionIndex];
      if (currentQuestion['type'] == 'single') {
        _answers[_currentQuestionIndex] = [option];
        // Auto-progress for single choice questions
        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
        } else {
          _showResults();
        }
      } else {
        // Multiple choice handling
        _answers[_currentQuestionIndex] = _answers[_currentQuestionIndex] ?? [];
        final currentAnswers = _answers[_currentQuestionIndex]!;
        if (currentAnswers.contains(option)) {
          currentAnswers.remove(option);
        } else {
          currentAnswers.add(option);
        }
      }
      debugPrint('Selected option(s) for question $_currentQuestionIndex: ${_answers[_currentQuestionIndex]}');
    });
  }

  void _handleNext() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        debugPrint('Moving to question: $_currentQuestionIndex');
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    debugPrint('Quiz complete!');
    // TODO: Navigate to results screen with calculated scores
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final isMultipleChoice = currentQuestion['type'] == 'multiple';
    final currentAnswers = _answers[_currentQuestionIndex] ?? [];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.pink],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _questions.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
                const SizedBox(height: 20),
                
                Text(
                  currentQuestion['text'],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (isMultipleChoice)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Select all that apply',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
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
                            backgroundColor: isSelected ? Colors.purple : Colors.white,
                            foregroundColor: isSelected ? Colors.white : Colors.black87,
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(option),
                        ),
                      );
                    },
                  ),
                ),
                
                if (isMultipleChoice)
                  ElevatedButton(
                    onPressed: currentAnswers.isNotEmpty ? _handleNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      _currentQuestionIndex == _questions.length - 1 
                        ? 'See Results' 
                        : 'Next',
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
