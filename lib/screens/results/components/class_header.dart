import 'package:flutter/material.dart';
import '../../../models/character_class.dart';

class ClassHeader extends StatelessWidget {
  final CharacterClass characterClass;

  const ClassHeader({
    super.key,
    required this.characterClass,
  });

  @override
  Widget build(BuildContext context) {
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
              characterClass.name,  // Changed from title to name
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
}