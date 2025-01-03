//... previous imports
import 'components/sparkle_overlay.dart';

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  bool _showSparkles = false;
  
  void _handleAnswerSelection(BuildContext context, Question question, dynamic answer) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.answerQuestion(question.id, answer);
    
    // Trigger sparkle effect
    setState(() => _showSparkles = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _showSparkles = false);
    });
    
    // Auto-progress for single-select questions
    if (!question.isMultipleChoice && !question.isScale) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          quizProvider.nextQuestion();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        // ... previous build code ...
        
        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _getGradientColors(currentProgress),
              ),
            ),
            child: SparkleOverlay(
              triggerEffect: _showSparkles,
              child: SafeArea(
                // ... rest of your existing build tree
              ),
            ),
          ),
        );
      },
    );
  }