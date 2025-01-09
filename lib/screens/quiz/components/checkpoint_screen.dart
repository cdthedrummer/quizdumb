import 'package:flutter/material.dart';

class CheckpointScreen extends StatelessWidget {
  final Map<String, double> scores;
  final String encouragingMessage;
  final VoidCallback onContinue;

  const CheckpointScreen({
    super.key,
    required this.scores,
    required this.encouragingMessage,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withAlpha(204), // 0.8 opacity
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 64,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                'Progress Checkpoint!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                encouragingMessage,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildScoresGrid(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onContinue,
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
                  'Continue Journey',
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
    );
  }

  Widget _buildScoresGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: scores.entries.map((entry) {
        final emoji = _getEmojiForAttribute(entry.key);
        return Card(
          color: _getColorForAttribute(entry.key).withAlpha(230), // 0.9 opacity
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                Text(
                  '${(entry.value * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getEmojiForAttribute(String attribute) {
    switch (attribute) {
      case 'Strength':
        return '💪';
      case 'Dexterity':
        return '🎯';
      case 'Constitution':
        return '🛡️';
      case 'Intelligence':
        return '🧠';
      case 'Wisdom':
        return '🔮';
      case 'Charisma':
        return '✨';
      default:
        return '🌟';
    }
  }

  Color _getColorForAttribute(String attribute) {
    switch (attribute) {
      case 'Strength':
        return Colors.red;
      case 'Dexterity':
        return Colors.green;
      case 'Constitution':
        return Colors.orange;
      case 'Intelligence':
        return Colors.blue;
      case 'Wisdom':
        return Colors.purple;
      case 'Charisma':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}