import 'package:flutter/material.dart';
// ... (other imports)

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  // ... (other state variables)

  void _handleAnswerSelection(BuildContext context, Question question, dynamic answer) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final previousAnswer = quizProvider.getAnswerForQuestion(question.id);
    quizProvider.answerQuestion(question.id, answer);
    
    // Only show effects for final answer selections
    if (!question.isScale && 
        (!question.isMultipleChoice || 
         (previousAnswer?.length ?? 0) < (answer as List).length)) {
      setState(() {
        _showSparkles = true;
        _showBurst = true;
      });
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _showSparkles = false;
            _showBurst = false;
          });
        }
      });
    }
  }
  
  // ... (rest of the code)
}