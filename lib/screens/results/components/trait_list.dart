import 'package:flutter/material.dart';

class TraitList extends StatelessWidget {
  final String title;
  final List<String> traits;
  final IconData icon;

  const TraitList({
    Key? key,
    required this.title,
    required this.traits,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withAlpha(51),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white.withAlpha(230),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
                  Text(
                    '•',
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      trait,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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