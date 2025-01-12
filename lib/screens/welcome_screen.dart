import 'package:flutter/material.dart';

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
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              _CategoryCard(
                title: 'STRENGTH',
                description: 'Physical capabilities, endurance, and raw power',
                tooltip: 'Train consistently to level up your physical stats',
                color: const Color(0xFFFF3B30),
                icon: Icons.fitness_center,
              ),
              _CategoryCard(
                title: 'INTELLIGENCE',
                description: 'Mental acuity, problem-solving, and learning',
                tooltip: 'Challenge your mind to boost these stats',
                color: const Color(0xFF30E3FF),
                icon: Icons.psychology,
              ),
              _CategoryCard(
                title: 'SOCIAL',
                description: 'Communication, empathy, and relationships',
                tooltip: 'Connect with others to enhance these traits',
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
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String tooltip;
  final Color color;
  final IconData icon;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.tooltip,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
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
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
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