// Previous imports...
import '../../widgets/animated_background.dart';

// Rest of the QuizScreen class remains the same until the build method
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final question = quizProvider.currentQuestion;
        final currentProgress = quizProvider.progress;
        final currentColors = _getGradientColors(currentProgress);

        // Check if quiz is complete and navigate to results
        if (quizProvider.status == QuizStatus.complete) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ResultsScreen(),
              ),
            );
          });
        }

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: currentColors,
              ),
            ),
            child: AnimatedBackground(
              colors: currentColors,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      // ... rest of the existing column content
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }