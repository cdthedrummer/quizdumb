import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import 'components/stat_radar_chart.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final scores = quizProvider.scores;
        final primaryAttribute = quizProvider.getPrimaryAttribute();
        final rankings = quizProvider.getAttributeRankings();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Your Results',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  if (primaryAttribute != null) ...[
                    Text(
                      'Primary Attribute: $primaryAttribute',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                  Expanded(
                    child: StatRadarChart(
                      scores: scores,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildAttributeRankings(context, rankings),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      quizProvider.resetQuiz();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retake Quiz'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttributeRankings(BuildContext context, Map<String, int> rankings) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attribute Rankings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...rankings.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(
                    entry.value.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}