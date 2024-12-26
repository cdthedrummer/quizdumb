import 'package:flutter/material.dart';

enum QuestionType { 
  singleChoice,
  multiChoice,
  scale,
  splash
}

enum Attribute {
  strength,
  dexterity,
  constitution,
  intelligence,
  wisdom,
  charisma
}

class Question {
  final String text;
  final List<String> options;
  final QuestionType type;
  final Map<String, List<Attribute>> attributeScores;
  final String? encouragementText;  // For splash screens
  final String? splashIcon;         // Emoji for splash screens
  
  const Question({
    required this.text,
    this.options = const [],        // Empty for splash screens
    required this.type,
    this.attributeScores = const {}, // Empty for splash screens
    this.encouragementText,
    this.splashIcon,
  });

  bool get isSplash => type == QuestionType.splash;
}

// Emojis for attributes
const Map<Attribute, String> attributeIcons = {
  Attribute.strength: '💪',
  Attribute.intelligence: '🧠',
  Attribute.wisdom: '🔮',
  Attribute.dexterity: '🎾',
  Attribute.charisma: '🌟',
  Attribute.constitution: '🛡️',
};

// Define the questions list
const List<Question> questions = [
  // First section: Learning and Growth
  Question(
    text: 'How do you prefer to learn?',
    options: ['Reading or studying', 'Watching a video', 'Doing it yourself', 'Group setting'],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Reading or studying': [Attribute.intelligence],
      'Watching a video': [Attribute.intelligence, Attribute.wisdom],
      'Doing it yourself': [Attribute.dexterity],
      'Group setting': [Attribute.charisma],
    },
  ),
  Question(
    text: 'What makes you feel energized?',
    options: ['Challenging yourself physically', 'Hanging out with friends', 'Quiet reflection time', 'Creating or making things'],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Challenging yourself physically': [Attribute.strength, Attribute.dexterity],
      'Hanging out with friends': [Attribute.charisma],
      'Quiet reflection time': [Attribute.wisdom],
      'Creating or making things': [Attribute.intelligence],
    },
  ),
  Question(
    text: 'Level Up! 🎮',
    type: QuestionType.splash,
    encouragementText: 'Great start! Your learning style says a lot about your natural talents. Let\'s explore more about your approach to life!',
    splashIcon: '🌱',
  ),
  // Health and Wellness Section
  Question(
    text: 'Where\'s your focus when it comes to trying to be healthy?',
    options: ['Eating well', 'Being active', 'Relaxing and taking it easy', 'Getting regular check-ups'],
    type: QuestionType.multiChoice,
    attributeScores: {
      'Eating well': [Attribute.constitution],
      'Being active': [Attribute.strength, Attribute.dexterity],
      'Relaxing and taking it easy': [Attribute.wisdom],
      'Getting regular check-ups': [Attribute.constitution],
    },
  ),
  Question(
    text: 'What kind of physical activity makes you happiest?',
    options: ['Outdoor adventures', 'Team sports', 'Solo workouts', 'Dancing or movement'],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Outdoor adventures': [Attribute.constitution, Attribute.dexterity],
      'Team sports': [Attribute.charisma, Attribute.strength],
      'Solo workouts': [Attribute.strength, Attribute.constitution],
      'Dancing or movement': [Attribute.dexterity, Attribute.charisma],
    },
  ),
  Question(
    text: 'Health Check! 💖',
    type: QuestionType.splash,
    encouragementText: 'Your approach to health is unique to you. Understanding it helps unlock your potential!',
    splashIcon: '🌟',
  ),
  // Problem Solving Section
  Question(
    text: 'How do you tackle tough problems?',
    options: ['Analyze and plan', 'Try different approaches', 'Seek advice', 'Trust your instincts'],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Analyze and plan': [Attribute.intelligence],
      'Try different approaches': [Attribute.dexterity],
      'Seek advice': [Attribute.charisma, Attribute.wisdom],
      'Trust your instincts': [Attribute.wisdom],
    },
  ),
  Question(
    text: 'What helps you recharge?',
    options: ['Time in nature', 'Games or puzzles', 'Social activities', 'Music or podcasts'],
    type: QuestionType.multiChoice,
    attributeScores: {
      'Time in nature': [Attribute.constitution, Attribute.wisdom],
      'Games or puzzles': [Attribute.intelligence],
      'Social activities': [Attribute.charisma],
      'Music or podcasts': [Attribute.wisdom],
    },
  ),
  Question(
    text: 'Milestone Reached! 🏆',
    type: QuestionType.splash,
    encouragementText: 'Your problem-solving style reveals your inner strengths. Let\'s discover more!',
    splashIcon: '💫',
  ),
  // Rating Scales Section
  Question(
    text: 'How much do you enjoy physical exercise?',
    options: ['1', '2', '3'],
    type: QuestionType.scale,
    attributeScores: {
      '3': [Attribute.strength, Attribute.constitution],
      '2': [Attribute.constitution],
      '1': [],
    },
  ),
  Question(
    text: 'How often do you seek out new experiences?',
    options: ['1', '2', '3'],
    type: QuestionType.scale,
    attributeScores: {
      '3': [Attribute.dexterity, Attribute.charisma],
      '2': [Attribute.dexterity],
      '1': [],
    },
  ),
  Question(
    text: 'Almost There! 🎯',
    type: QuestionType.splash,
    encouragementText: 'You\'re doing great! Just a few more questions to complete your character sheet!',
    splashIcon: '✨',
  ),
  Question(
    text: 'How much do you enjoy meeting new people?',
    options: ['1', '2', '3'],
    type: QuestionType.scale,
    attributeScores: {
      '3': [Attribute.charisma, Attribute.wisdom],
      '2': [Attribute.charisma],
      '1': [],
    },
  ),
  Question(
    text: 'How often do you prioritize your mental and physical health?',
    options: ['1', '2', '3'],
    type: QuestionType.scale,
    attributeScores: {
      '3': [Attribute.constitution, Attribute.wisdom],
      '2': [Attribute.constitution],
      '1': [],
    },
  ),
  Question(
    text: 'Quest Complete! 🎊',
    type: QuestionType.splash,
    encouragementText: 'Amazing work! Let\'s see what your responses reveal about your character build!',
    splashIcon: '🌈',
  ),
];