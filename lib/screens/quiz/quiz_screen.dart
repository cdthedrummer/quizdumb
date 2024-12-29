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

  // State management methods
  void _handleAnswer(dynamic answer) {
    setState(() {
      _answers[_currentIndex] = answer;
      if (_currentIndex < widget.questions.length - 1) {
        _currentIndex++;
      } else {
        _showResults();
      }
    });
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
      if (question.isScale && answer is int) {
        question.scaleAttributes?.forEach((attribute, baseValue) {
          scores[attribute] = (scores[attribute] ?? 3) + (baseValue * answer);
        });
      } else if (answer is List<String>) {
        for (final option in answer) {
          question.attributes?[option]?.forEach((attribute, value) {
            scores[attribute] = (scores[attribute] ?? 3) + value;
          });
        }
      }
    });

    return QuizResult(scores: scores);
  }

  void _showResults() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          result: _calculateResults(),
        ),
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
                const SizedBox(height: 20),
                Text(
                  currentQuestion.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: currentQuestion.isScale
                    ? ScaleSelector(
                        value: (currentAnswer as int?) ?? 0,
                        onChanged: _handleAnswer,
                      )
                    : AnswerOptions(
                        question: currentQuestion,
                        selectedAnswers: (currentAnswer as List<String>?) ?? [],
                        onOptionSelected: (option) => _handleAnswer([option]),
                      ),
                ),
                if (_currentIndex > 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex--;
                      });
                    },
                    child: const Text('Back'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}