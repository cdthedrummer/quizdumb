import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<String> options;
  final QuestionType type;
  final Map<String, int> attributeScores;
  final String? emoji;

  Question({
    required this.text,
    required this.options,
    required this.type,
    required this.attributeScores,
    this.emoji,
  });
}

enum QuestionType {
  singleChoice,
  slider,
  multiSelect,
}

final List<Question> questions = [
  // Single Choice Questions (First 4)
  Question(
    text: "How do you prefer to recharge? 🔋",
    options: [
      "Solo workout 💪",
      "Coffee with friends ☕",
      "Reading a book 📚",
      "Creative project 🎨"
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'strength': 3,
      'charisma': 2,
      'wisdom': 2,
      'intelligence': 3
    },
  ),
  Question(
    text: "What's your idea of fun? 🎉",
    options: [
      "Sports game 🏃",
      "Board game night 🎲",
      "Learning something new 🧠",
      "Making music 🎵"
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'dexterity': 3,
      'charisma': 2,
      'intelligence': 3,
      'wisdom': 2
    },
  ),
  Question(
    text: "When facing a challenge... 💭",
    options: [
      "Power through 💪",
      "Ask for help 🤝",
      "Plan it out 📝",
      "Trust your gut 🎯"
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'strength': 3,
      'charisma': 3,
      'intelligence': 2,
      'wisdom': 2
    },
  ),
  Question(
    text: "Best way to learn? 📚",
    options: [
      "Just do it 🏃",
      "Watch others 👀",
      "Read guides 📖",
      "Group practice 👥"
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'dexterity': 3,
      'wisdom': 2,
      'intelligence': 3,
      'charisma': 2
    },
  ),

  // Slider Questions (Middle 4)
  Question(
    text: "How often do you exercise? 💪",
    options: ["Rarely", "Sometimes", "Often", "Daily"],
    type: QuestionType.slider,
    attributeScores: {
      'strength': 3,
      'constitution': 2,
    },
  ),
  Question(
    text: "How social are you? 🤝",
    options: ["Quiet", "Reserved", "Social", "Life of the party"],
    type: QuestionType.slider,
    attributeScores: {
      'charisma': 3,
      'wisdom': 1,
    },
  ),
  Question(
    text: "How often do you try new things? 🌟",
    options: ["Rarely", "Sometimes", "Often", "Always"],
    type: QuestionType.slider,
    attributeScores: {
      'dexterity': 2,
      'wisdom': 2,
      'intelligence': 1,
    },
  ),
  Question(
    text: "How's your health routine? ❤️",
    options: ["Basic", "Good", "Great", "Perfect"],
    type: QuestionType.slider,
    attributeScores: {
      'constitution': 3,
      'wisdom': 2,
    },
  ),

  // Multi-Select Questions (Last 4)
  Question(
    text: "Pick your stress-busters 😌",
    options: [
      "Exercise 🏃",
      "Meditation 🧘",
      "Friends 👥",
      "Hobbies 🎨"
    ],
    type: QuestionType.multiSelect,
    attributeScores: {
      'constitution': 2,
      'wisdom': 2,
      'charisma': 2,
      'dexterity': 2,
    },
  ),
  Question(
    text: "What interests you? 🤔",
    options: [
      "Sports 🏃",
      "Art 🎨",
      "Tech 💻",
      "Nature 🌿"
    ],
    type: QuestionType.multiSelect,
    attributeScores: {
      'dexterity': 2,
      'charisma': 2,
      'intelligence': 2,
      'wisdom': 2,
    },
  ),
  Question(
    text: "Weekend goals? 🎯",
    options: [
      "Active fun 🏃",
      "Chill time 😌",
      "Learn stuff 📚",
      "Meet people 🤝"
    ],
    type: QuestionType.multiSelect,
    attributeScores: {
      'strength': 2,
      'constitution': 2,
      'intelligence': 2,
      'charisma': 2,
    },
  ),
  Question(
    text: "Pick your skills to level up ⬆️",
    options: [
      "Fitness 💪",
      "Social 👥",
      "Creative 🎨",
      "Mental 🧠"
    ],
    type: QuestionType.multiSelect,
    attributeScores: {
      'strength': 2,
      'charisma': 2,
      'wisdom': 2,
      'intelligence': 2,
    },
  ),
];