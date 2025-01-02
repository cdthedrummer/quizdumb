import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/stat_radar_chart.dart';
import '../../data/character_classes.dart';
import 'components/trait_list.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  CharacterClass _getCharacterClass(Map<String, int> scores) {
    // Find highest scoring attribute
    var maxScore = 0;
    String primaryStat = '';
    scores.forEach((key, value) {
      if (value > maxScore) {
        maxScore = value;
        primaryStat = key;
      }
    });

    // Find matching character class
    return characterClasses.firstWhere(
      (c) => c.primaryStat == primaryStat,
      orElse: () => characterClasses.last, // Default to Jack of All Trades
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final scores = quizProvider.scores;
        final characterClass = _getCharacterClass(scores);

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
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Character Emoji
                        Text(
                          characterClass.emoji,
                          style: const TextStyle(fontSize: 64),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        // Title
                        Text(
                          characterClass.name,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        Text(
                          characterClass.title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Quicksand',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        
                        // Description
                        Card(
                          color: Colors.white.withOpacity(0.15),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: _buildStyledDescription(characterClass.description),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Stats
                        Card(
                          color: Colors.white.withOpacity(0.15),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Your Stats',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                                const SizedBox(height: 32),
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
                        const SizedBox(height: 24),
                        
                        // Key Traits
                        _buildTraitSection(
                          title: 'Key Traits',
                          icon: Icons.stars,
                          traits: characterClass.keyTraits,
                        ),
                        const SizedBox(height: 16),
                        
                        // Growth Areas
                        _buildTraitSection(
                          title: 'Growth Areas',
                          icon: Icons.trending_up,
                          traits: characterClass.growthAreas,
                        ),
                        const SizedBox(height: 24),
                        
                        // Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                quizProvider.resetQuiz();
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Try Again'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Implement detailed view
                              },
                              icon: const Icon(Icons.auto_awesome),
                              label: const Text('View Details'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF5E35B1),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
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

  TextSpan _buildStyledDescription(String description) {
    final parts = description.split('**');
    final spans = <TextSpan>[];
    
    for (var i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        spans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Quicksand',
          ),
        ));
      } else {
        spans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ));
      }
    }
    
    return TextSpan(children: spans);
  }

  Widget _buildTraitSection({
    required String title,
    required IconData icon,
    required List<String> traits,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white),
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
            ...traits.map((trait) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '•',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      trait,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}