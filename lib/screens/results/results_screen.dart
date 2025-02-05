import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/character_class.dart';
import '../../providers/quiz_provider.dart';
import '../../data/character_classes.dart';
import '../welcome_screen.dart';
import '../quiz/components/stat_radar_chart.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final scores = quizProvider.scores;
        final characterClass = _determineCharacterClass(scores);

        return WillPopScope(
          onWillPop: () async {
            quizProvider.resetQuiz();
            return true;
          },
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withAlpha(204),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Your Adventure Class',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        _buildCharacterSection(characterClass),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 300,
                          child: StatRadarChart(scores: scores),
                        ),
                        const SizedBox(height: 32),
                        _buildAttributeSection(
                          'Your Strengths',
                          _getTopAttributes(scores),
                          Icons.star,
                          Colors.amber,
                        ),
                        const SizedBox(height: 24),
                        _buildAttributeSection(
                          'Areas to Level Up',
                          _getImprovementAreas(scores),
                          Icons.trending_up,
                          Colors.greenAccent,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            quizProvider.resetQuiz();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Start New Quest',
                            style: TextStyle(
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
            ),
          ),
        );
      },
    );
  }

  CharacterClass _determineCharacterClass(Map<String, double> scores) {
    if (scores.isEmpty) return characterClasses.first;

    var bestMatch = characterClasses.first;
    var highestScore = 0.0;

    for (final characterClass in characterClasses) {
      var currentScore = 0.0;
      var totalWeight = 0.0;

      characterClass.attributeWeights.forEach((attribute, weight) {
        if (scores.containsKey(attribute)) {
          currentScore += scores[attribute]! * weight;
          totalWeight += weight;
        }
      });

      if (totalWeight > 0) {
        final normalizedScore = currentScore / totalWeight;
        if (normalizedScore > highestScore) {
          highestScore = normalizedScore;
          bestMatch = characterClass;
        }
      }
    }

    return bestMatch;
  }

  List<String> _getTopAttributes(Map<String, double> scores) {
    if (scores.isEmpty) return [];
    
    final sortedEntries = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sortedEntries.take(3).map((e) => e.key).toList();
  }

  List<String> _getImprovementAreas(Map<String, double> scores) {
    if (scores.isEmpty) return [];
    
    final sortedEntries = scores.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    
    return sortedEntries.take(2).map((e) => e.key).toList();
  }

  Widget _buildCharacterSection(CharacterClass characterClass) {
    return Card(
      color: Colors.white.withAlpha(51),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              characterClass.emoji,
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 8),
            Text(
              characterClass.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              characterClass.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Quicksand',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeSection(
    String title,
    List<String> attributes,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white.withAlpha(51),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: attributes.map((attr) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '• $attr',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                ),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}