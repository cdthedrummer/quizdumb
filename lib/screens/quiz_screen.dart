import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProgressBar(progress: 0.5),
            Expanded(
              child: QuestionCard(
                question: 'How do you prefer to learn?',
                options: const ['Reading', 'Watching', 'Doing', 'Group'],
                onAnswer: (answer) {
                  // Handle answer
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}