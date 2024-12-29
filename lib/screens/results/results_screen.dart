// Previous imports remain the same...

class ResultsScreen extends StatefulWidget {
  final QuizResult result;

  const ResultsScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with SingleTickerProviderStateMixin {
  // Previous state variables and initState remain the same...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  ClassHeader(characterClass: characterClass),
                  const SizedBox(height: 24),

                  // Description Card (moved up)
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

                  // Stats Card (moved down)
                  Card(
                    color: Colors.white.withAlpha(26),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Your Stats',
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 300,
                            child: StatRadarChart(
                              scores: widget.result.scores,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Traits and Growth areas remain the same...
                  TraitList(
                    title: 'Key Traits',
                    traits: characterClass.keyTraits,
                    icon: Icons.stars,
                  ),
                  const SizedBox(height: 16),
                  TraitList(
                    title: 'Growth Areas',
                    traits: characterClass.growthAreas,
                    icon: Icons.trending_up,
                  ),
                  const SizedBox(height: 24),

                  // Navigation buttons remain the same...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
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
                          HapticFeedback.mediumImpact();
                          debugPrint('Showing detailed view');
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
      ),
    );
  }
}