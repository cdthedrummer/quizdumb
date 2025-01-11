import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz/quiz_screen.dart';
import '../widgets/animated_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  final List<Color> _gradientColors = const [
    Color(0xFF9575CD),
    Color(0xFF5E35B1),  // Purple theme
  ];

  void _startQuiz(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    provider.startQuiz();
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        colors: _gradientColors,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/welcome_title.png',
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Explore untapped talents and\ngain the edge you\'ve been looking for!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const AttributeGrid(),
                          // Start Button
                          ElevatedButton(
                            onPressed: () => _startQuiz(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              'Begin quest',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AttributeGrid extends StatelessWidget {
  const AttributeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            AttributeIcon(emoji: '💪', label: 'Strength'),
            AttributeIcon(emoji: '🧠', label: 'Intelligence'),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            AttributeIcon(emoji: '🔮', label: 'Wisdom'),
            AttributeIcon(emoji: '🎾', label: 'Dexterity'),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            AttributeIcon(emoji: '🌟', label: 'Charisma'),
            AttributeIcon(emoji: '🛡️', label: 'Constitution'),
          ],
        ),
      ],
    );
  }
}

class AttributeIcon extends StatelessWidget {
  final String emoji;
  final String label;

  const AttributeIcon({
    super.key,
    required this.emoji,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }
}