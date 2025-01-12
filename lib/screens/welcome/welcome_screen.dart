import 'package:flutter/material.dart';

class StatTooltip extends StatelessWidget {
  final String content;
  
  const StatTooltip({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF141824),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'UNLOCK YOUR POTENTIAL',
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              _buildCategoryCard(
                title: 'STRENGTH',
                description: 'Physical capabilities, endurance, and raw power',
                tooltip: 'Your physical prowess combines raw strength, endurance, and athletic ability. Train consistently to level up your physical stats.',
                color: const Color(0xFFFF3B30),
                icon: Icons.fitness_center,
              ),
              _buildCategoryCard(
                title: 'INTELLIGENCE',
                description: 'Mental acuity, problem-solving, and learning',
                tooltip: 'Your mental capabilities include learning speed, problem-solving skills, and analytical thinking. Challenge your mind to boost these stats.',
                color: const Color(0xFF30E3FF),
                icon: Icons.psychology,
              ),
              _buildCategoryCard(
                title: 'SOCIAL',
                description: 'Communication, empathy, and relationships',
                tooltip: 'Your social abilities cover communication skills, emotional intelligence, and relationship building. Connect with others to enhance these traits.',
                color: const Color(0xFFFFD700),
                icon: Icons.people,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigate to quiz
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF30E3FF),
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'BEGIN YOUR JOURNEY',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF141824),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String description,
    required String tooltip,
    required Color color,
    required IconData icon,
  }) {
    return Tooltip(
      message: tooltip,
      preferBelow: false,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF141824),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            bottom: BorderSide(color: color, width: 3),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}