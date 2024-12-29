import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Map<String, String> attributeIcons = {
    'Strength': '💪',
    'Dexterity': '🎯',
    'Constitution': '🛡️',
    'Intelligence': '🧠',
    'Wisdom': '🔮',
    'Charisma': '⭐',
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isPortrait = size.height > size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(204), // 0.8 opacity
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.02,
                    ),
                    child: Image.asset(
                      'assets/images/welcome_title.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Explore untapped talents and gain the edge you\'ve been looking for!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                      fontFamily: 'Quicksand',
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.04),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isPortrait ? size.width : size.width * 0.7,
                    ),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: attributeIcons.entries.map((entry) {
                        return SizedBox(
                          width: isPortrait ? size.width * 0.28 : size.width * 0.15,
                          child: Column(
                            children: [
                              Text(
                                entry.value,
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontFamily: 'Quicksand',
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: false,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      'Begin quest',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}