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

  void _handleMultiSelect(String option) {
    setState(() {
      final currentAnswers = List<String>.from(
        (_answers[_currentIndex] as List<String>?) ?? []
      );

      if (currentAnswers.contains(option)) {
        currentAnswers.remove(option);
      } else {
        currentAnswers.add(option);
      }
      _answers[_currentIndex] = currentAnswers;
    });
  }

  void _handleSingleSelect(String option) {
    setState(() {
      _answers[_currentIndex] = [option];
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_currentIndex < widget.questions.length - 1) {
          setState(() => _currentIndex++);
        } else {
          _showResults();
        }
      });
    });
  }

  void _handleScale(double value) {
    setState(() {
      _answers[_currentIndex] = value;
    });
  }

  bool _canProceed() {
    final currentQuestion = widget.questions[_currentIndex];
    final answer = _answers[_currentIndex];
    
    if (currentQuestion.isMultipleChoice) {
      return (answer as List<String>?)?.isNotEmpty ?? false;
    }
    return answer != null;
  }

  void _proceedToNext() {
    if (_canProceed()) {
      if (_currentIndex < widget.questions.length - 1) {
        setState(() => _currentIndex++);
      } else {
        _showResults();
      }
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
      if (question.isScale && answer is double) {
        question.scaleAttributes?.forEach((attribute, baseValue) {
          scores[attribute] = (scores[attribute] ?? 3) + 
              (baseValue * ((answer.round() - 4) / 3)).round();
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
                        value: (currentAnswer as double?) ?? 4.0,
                        onChanged: _handleScale,
                        labels: currentQuestion.scaleLabels,
                      )
                    : AnswerOptions(
                        question: currentQuestion,
                        selectedAnswers: (currentAnswer as List<String>?) ?? [],
                        onOptionSelected: currentQuestion.isMultipleChoice 
                          ? _handleMultiSelect 
                          : _handleSingleSelect,
                      ),
                ),
                if (!currentQuestion.isSingleChoice)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: _canProceed() ? _proceedToNext : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
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
                        _currentIndex == widget.questions.length - 1 
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
                if (_currentIndex > 0)
                  TextButton(
                    onPressed: () => setState(() => _currentIndex--),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white70),
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