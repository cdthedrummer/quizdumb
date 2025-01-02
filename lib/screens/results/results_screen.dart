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
        final characterClass = _getCharacterClass(primaryAttribute);
        
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF9575CD), // Light purple
                  Color(0xFF5E35B1), // Dark purple
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Character Icon
                      Icon(
                        _getCharacterIcon(primaryAttribute),
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      
                      // Character Class Title
                      Text(
                        characterClass.title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      
                      // Subtitle
                      Text(
                        characterClass.subtitle,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      
                      // Description Card
                      Card(
                        color: Colors.white.withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            characterClass.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Stats Title Card
                      Card(
                        color: Colors.white.withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text(
                                'Your Stats',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 300,
                                child: StatRadarChart(
                                  scores: scores,
                                  primaryColor: Colors.white,
                                  backgroundColor: Colors.white24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Retry Button
                      ElevatedButton.icon(
                        onPressed: () {
                          quizProvider.resetQuiz();
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF5E35B1),
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getCharacterIcon(String? attribute) {
    switch (attribute?.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'intelligence':
        return Icons.psychology;
      case 'wisdom':
        return Icons.auto_awesome;
      case 'dexterity':
        return Icons.sports_gymnastics;
      case 'charisma':
        return Icons.star;
      case 'constitution':
        return Icons.favorite;
      default:
        return Icons.person;
    }
  }

  ({String title, String subtitle, String description}) _getCharacterClass(String? attribute) {
    switch (attribute?.toLowerCase()) {
      case 'strength':
        return (
          title: 'Warrior',
          subtitle: 'The Path of Power',
          description: 'You are a natural leader with impressive physical capabilities. Your strength and determination make you excel in challenging situations.',
        );
      case 'intelligence':
        return (
          title: 'Wizard',
          subtitle: 'The Seeker of Knowledge',
          description: 'You are an intellectual powerhouse with an unquenchable thirst for knowledge. Your analytical mind and love for learning make you a natural problem solver and innovator.',
        );
      case 'wisdom':
        return (
          title: 'Sage',
          subtitle: 'The Voice of Reason',
          description: 'Your intuitive understanding and careful consideration of situations make you an excellent advisor and decision maker.',
        );
      case 'dexterity':
        return (
          title: 'Rogue',
          subtitle: 'The Master of Finesse',
          description: 'Your quick reflexes and natural agility make you exceptionally skilled at tasks requiring precision and coordination.',
        );
      case 'charisma':
        return (
          title: 'Bard',
          subtitle: 'The Heart of Inspiration',
          description: 'Your natural charm and social grace make you a born leader and connector. You excel at bringing people together and inspiring others.',
        );
      case 'constitution':
        return (
          title: 'Guardian',
          subtitle: 'The Pillar of Strength',
          description: 'Your resilience and stamina are remarkable. You have excellent self-discipline and maintain a strong focus on personal well-being.',
        );
      default:
        return (
          title: 'Adventurer',
          subtitle: 'The Balanced Soul',
          description: 'You have a well-rounded approach to life, showing potential in multiple areas. Your versatility is your greatest strength.',
        );
    }
  }
}