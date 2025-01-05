// ... previous imports and code ...

  Widget _buildQuestionWidget(Question question, QuizProvider provider) {
    if (question.isScale) {
      return ScaleQuestion(
        labels: question.scaleLabels!,
        value: provider.getAnswerForQuestion(question.id)?.first != null
            ? int.parse(provider.getAnswerForQuestion(question.id)!.first)
            : 4,
        onChanged: (value) {
          setState(() => _isScaleInteracting = true);
          _handleAnswerSelection(context, question, value, answerPosition: null);
        },
        onInteractionEnd: () {
          setState(() => _isScaleInteracting = false);
        },
      );
    }

    return MultipleChoiceQuestion(
      options: question.options!,
      isMultiSelect: question.isMultipleChoice,
      selectedAnswers: provider.getAnswerForQuestion(question.id) ?? [],
      onAnswerSelected: (answers, position) => 
          _handleAnswerSelection(context, question, answers, answerPosition: position),
    );
  }

// ... rest of the quiz screen code ...