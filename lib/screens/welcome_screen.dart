import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/animated_gradient_container.dart';
import '../data/questions.dart';
import 'quiz/quiz_screen.dart';

class AttributeIcon extends StatelessWidget {
  final String emoji;
  final String label;

  const AttributeIcon({
    Key? key,
    required this.emoji,
    required this.label,
  }) : super(key: key);

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

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void _startQuiz(BuildContext context) {
    HapticFeedback.mediumImpact();
    debugPrint('Starting quiz with ${quizQuestions.length} questions');
    
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => QuizScreen(
          questions: quizQuestions,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientContainer(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Welcome to your',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Image.asset(
                                'assets/images/welcome_title.png',
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Explore untapped talents and\ngain the edge you\'ve been\nlooking for!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          
                          // Attribute Icons Grid
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AttributeIcon(emoji: '💪', label: 'Strength'),
                                    AttributeIcon(emoji: '🧠', label: 'Intelligence'),
                                  ],
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AttributeIcon(emoji: '🔮', label: 'Wisdom'),
                                    AttributeIcon(emoji: '🎾', label: 'Dexterity'),
                                  ],
                                ),
                                SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AttributeIcon(emoji: '🌟', label: 'Charisma'),
                                    AttributeIcon(emoji: '🛡️', label: 'Constitution'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Start Button
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ElevatedButton(
                              onPressed: () => _startQuiz(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}