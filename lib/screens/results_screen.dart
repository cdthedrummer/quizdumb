import 'package:flutter/material.dart';
import '../models/result.dart';
import '../models/character_class.dart';
import '../services/class_calculator.dart';

class ResultsScreen extends StatefulWidget {
  final QuizResult result;

  const ResultsScreen({Key? key, required this.result}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late final CharacterClass characterClass;
  final ClassCalculator _calculator = ClassCalculator();

  @override
  void initState() {
    super.initState();
    debugPrint('Calculating character class for scores: ${widget.result.scores}');
    characterClass = _calculator.determineClass(widget.result.scores);
    debugPrint('Determined character class: ${characterClass.name}');
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Character Class Header
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
                const SizedBox(height: 24),

                // Description Card
                Card(
                  color: Colors.white.withAlpha(51),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      characterClass.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Stats Overview (placeholder for radar chart)
                Text(
                  'Your Stats',
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // TODO: Add radar chart here
                Container(
                  height: 200,
                  color: Colors.white.withAlpha(26),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Stats Visualization Coming Soon!',
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Navigation Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Retaking quiz');
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          '/',  // Assuming '/' is your welcome/start screen
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withAlpha(51),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Retake Quiz',
                        style: TextStyle(fontFamily: 'Quicksand'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Viewing details');
                        // TODO: Implement detailed view
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withAlpha(230),
                        foregroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(fontFamily: 'Quicksand'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}