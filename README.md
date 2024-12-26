# Personal Growth Quiz App

A Flutter-based quiz app that helps users discover their strengths and areas for growth using D&D-style attributes.

## Getting Started

1. Install Flutter by following the [official installation guide](https://flutter.dev/docs/get-started/install)
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Features

- Engaging personality quiz
- D&D-style attribute system
- Visual progress tracking
- Detailed results analysis
- Personalized improvement suggestions

## Project Structure

```
lib/
  ├── main.dart           # App entry point
  ├── models/             # Data models
  │   ├── question.dart   # Question model
  │   └── result.dart     # Result model
  ├── screens/            # UI screens
  │   ├── welcome_screen.dart
  │   ├── quiz_screen.dart
  │   └── results_screen.dart
  └── widgets/            # Reusable widgets
      ├── progress_bar.dart
      └── question_card.dart
```