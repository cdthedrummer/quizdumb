// Previous imports remain the same...

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  // _startQuiz method remains the same...

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
                          
                          // Rest of the content remains the same...
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