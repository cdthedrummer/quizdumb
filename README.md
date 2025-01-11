# QuizDumb App Structure

```
lib/
├── config/                     # App configuration
│   ├── constants.dart         # App-wide constants
│   └── routes.dart           # Route definitions
│
├── core/                      # Core functionality
│   ├── exceptions/           # Custom exceptions
│   ├── utils/               # Utility functions
│   └── extensions/          # Dart extensions
│
├── data/                     # Data layer
│   ├── models/              # Data models
│   │   ├── question.dart
│   │   ├── result.dart
│   │   └── character_class.dart
│   └── repositories/        # Data repositories
│       └── quiz_repository.dart
│
├── providers/               # State management
│   └── quiz_provider.dart
│
├── screens/                 # UI screens
│   ├── welcome/            # Welcome screen
│   │   ├── components/    # Screen-specific components
│   │   └── welcome_screen.dart
│   ├── quiz/              # Quiz screen
│   │   ├── components/    # Quiz-specific components
│   │   └── quiz_screen.dart
│   └── results/           # Results screen
│       ├── components/    # Results-specific components
│       └── results_screen.dart
│
├── shared/                 # Shared components
│   ├── widgets/           # Reusable widgets
│   │   ├── animated_background.dart
│   │   └── success_burst.dart
│   └── animations/        # Shared animations
│
├── theme/                 # App theming
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   └── app_theme.dart
│
└── main.dart             # App entry point
```

## Core Features
- Use nullable types only when necessary
- Keep business logic in provider/repository layer
- Maintain single responsibility principle
- Consistent file and class naming

## Best Practices
- Keep widgets focused and small
- Use const constructors where possible
- Extract magic numbers to constants
- Handle errors gracefully