import 'package:flutter/material.dart';
import '../models/result.dart';

class ResultsScreen extends StatelessWidget {
  static const Map<String, String> attributeIcons = {
    'Strength': '💪',
    'Dexterity': '🎯',
    'Constitution': '🛡️',
    'Intelligence': '🧠',
    'Wisdom': '🔮',
    'Charisma': '⭐',
  };

  final QuizResult result;

  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final maxScore = result.sortedScores.first.value.toDouble();
    
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  '🎯 Quest Complete! 🎯',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      attributeIcons[result.primaryAttribute] ?? '',
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      result.primaryAttribute,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: result.sortedScores.length,
                    itemBuilder: (context, index) {
                      final score = result.sortedScores[index];
                      final progressValue = score.value / maxScore;
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(26),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    attributeIcons[score.key] ?? '',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      score.key,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Quicksand',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    score.value.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  backgroundColor: Colors.white.withAlpha(26),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white.withAlpha(204),
                                  ),
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}