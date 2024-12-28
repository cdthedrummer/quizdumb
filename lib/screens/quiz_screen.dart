import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  Map<int, String> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'text': 'How do you prefer to learn?',
      'options': ['Reading', 'Watching', 'Doing', 'Group'],
    },
    {
      'id': 2,
      'text': 'What energizes you most?',
      'options': [
        'Physical challenges',
        'Mental puzzles',
        'Creative expression',
        'Helping others'
      ],
    },
  ];

  void _handleOptionSelected(String option) {
    setState(() {
      _answers[_currentQuestionIndex] = option;
      debugPrint('Selected option: $option');
    });
  }

  void _handleNext() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        debugPrint('Moving to question: $_currentQuestionIndex');
      });
    } else {
      debugPrint('Quiz complete!');
      // Navigate to results
    }
  }

  @override
  Widget build(BuildContext context) {
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
                // Progress indicator
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _questions.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
                const SizedBox(height: 20),
                
                // Question text
                Text(
                  _questions[_currentQuestionIndex]['text'],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                // Options
                Expanded(
                  child: ListView.builder(
                    itemCount: _questions[_currentQuestionIndex]['options'].length,
                    itemBuilder: (context, index) {
                      final option = _questions[_currentQuestionIndex]['options'][index];
                      final isSelected = _answers[_currentQuestionIndex] == option;
                      
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
                
                // Next button
                ElevatedButton(
                  onPressed: _answers[_currentQuestionIndex] != null ? _handleNext : null,
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