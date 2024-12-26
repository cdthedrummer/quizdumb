import 'package:flutter/material.dart';
import '../models/result.dart';

class ResultsScreen extends StatelessWidget {
  final QuizResult result;

  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Your Results',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: result.sortedScores.map((score) => ListTile(
                  title: Text(score.key),
                  trailing: Text(score.value.toString()),
                )).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Start Over'),
            ),
          ],
        ),
      ),
    );
  }
}