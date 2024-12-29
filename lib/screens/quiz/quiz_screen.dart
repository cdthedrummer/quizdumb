import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/quiz_state.dart';
import '../../models/question.dart';
import '../../widgets/animated_gradient_container.dart';
import '../results/results_screen.dart';
import 'components/progress_bar.dart';
import 'components/question_card.dart';
import 'components/answer_options.dart';
import 'components/navigation_buttons.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;

  const QuizScreen({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late final QuizState quizState;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    debugPrint('Initializing QuizScreen');
    
    quizState = QuizState(questions: widget.questions);
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleOptionSelected(String option) {
    HapticFeedback.lightImpact();
    setState(() {
      quizState.selectOption(option);
      
      if (!quizState.currentQuestion.isMultipleChoice) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!quizState.isLastQuestion) {
            _animationController.forward();
            setState(() {
              quizState.nextQuestion();
            });
          } else {
            _showResults();
          }
        });
      }
    });
  }

  void _handleNext() {
    if (!quizState.isLastQuestion) {
      _animationController.forward();
      setState(() {
        quizState.nextQuestion();
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    debugPrint('Quiz completed, showing results');
    final result = quizState.calculateResults();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ResultsScreen(result: result),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              QuizProgressBar(progress: quizState.progress),
              const SizedBox(height: 20),
              
              QuestionCard(
                question: quizState.currentQuestion,
                fadeAnimation: _fadeAnimation,
              ),
              const SizedBox(height: 40),
              
              Expanded(
                child: SingleChildScrollView(
                  child: AnswerOptions(
                    question: quizState.currentQuestion,
                    selectedAnswers: quizState.currentAnswers,
                    onOptionSelected: _handleOptionSelected,
                  ),
                ),
              ),
              
              if (quizState.currentQuestion.isMultipleChoice && quizState.currentAnswers.isNotEmpty)
                NavigationButtons(
                  isLastQuestion: quizState.isLastQuestion,
                  hasAnswers: quizState.currentAnswers.isNotEmpty,
                  onNext: _handleNext,
                ),
            ],
          ),
        ),
      ),
    );
  }
}