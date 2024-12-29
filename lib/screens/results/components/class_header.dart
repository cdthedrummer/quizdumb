import 'package:flutter/material.dart';
import '../../../models/character_class.dart';

class ClassHeader extends StatelessWidget {
  final CharacterClass characterClass;

  const ClassHeader({
    Key? key,
    required this.characterClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          characterClass.emoji,
          style: const TextStyle(fontSize: 48),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          characterClass.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          characterClass.title,
          style: TextStyle(
            color: Colors.white.withAlpha(230),
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontFamily: 'Quicksand',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}