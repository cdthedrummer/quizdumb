import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/questions.dart';
import '../widgets/animated_gradient_container.dart';
import 'quiz/quiz_screen.dart';

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
                          // Title Image
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Image.asset(
                              'assets/images/welcome_title.png',
                              width: constraints.maxWidth * 0.8,
                              fit: BoxFit.contain,
                            ),
                          ),
                          
                          const Text(
                            'Explore untapped talents and\ngain the edge you\'ve been\nlooking for!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Quicksand',
                            ),
                            textAlign: TextAlign.center,
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