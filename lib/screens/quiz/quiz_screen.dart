// In imports section at top
import '../../widgets/animated_background.dart';

// In the Scaffold's body, replace the AnimatedContainer with:
          body: AnimatedBackground(
            colors: currentColors,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    // ... rest of your existing Column content
                  ),
                ),
              ),
            ),
          ),