import '../models/question.dart';

final List<Question> quizQuestions = [
  // Single choice questions
  Question(
    id: 1,
    text: 'What draws you to learn something new?',
    type: 'single',
    options: [
      'Understanding how things work',
      'Mastering a practical skill',
      'Growing as a person',
      'Meeting new people',
    ],
    attributes: {
      'Understanding how things work': {'Intelligence': 2, 'Wisdom': 1},
      'Mastering a practical skill': {'Dexterity': 2, 'Strength': 1},
      'Growing as a person': {'Wisdom': 2, 'Constitution': 1},
      'Meeting new people': {'Charisma': 2, 'Wisdom': 1},
    },
  ),
  
  // Multiple choice questions
  Question(
    id: 2,
    text: 'How do you stay healthy?',
    type: 'multiple',
    options: [
      'Regular exercise',
      'Balanced diet',
      'Mental wellness',
      'Social activities',
    ],
    attributes: {
      'Regular exercise': {'Strength': 1, 'Dexterity': 1},
      'Balanced diet': {'Constitution': 2},
      'Mental wellness': {'Wisdom': 2},
      'Social activities': {'Charisma': 2},
    },
  ),
  
  Question(
    id: 3,
    text: 'What are your favorite ways to spend free time?',
    type: 'multiple',
    options: [
      'Physical activities',
      'Learning new things',
      'Creative projects',
      'Social gatherings',
    ],
    attributes: {
      'Physical activities': {'Strength': 2, 'Dexterity': 1},
      'Learning new things': {'Intelligence': 2, 'Wisdom': 1},
      'Creative projects': {'Intelligence': 1, 'Dexterity': 2},
      'Social gatherings': {'Charisma': 2},
    },
  ),

  // Single choice for life goals
  Question(
    id: 4,
    text: 'What matters most in your future plans?',
    type: 'single',
    options: [
      'Personal growth',
      'Making an impact',
      'Building relationships',
      'Achieving goals',
    ],
    attributes: {
      'Personal growth': {'Wisdom': 2, 'Constitution': 1},
      'Making an impact': {'Intelligence': 2, 'Charisma': 1},
      'Building relationships': {'Charisma': 2, 'Wisdom': 1},
      'Achieving goals': {'Strength': 2, 'Constitution': 1},
    },
  ),

  // Scale questions with custom labels
  Question(
    id: 5,
    text: 'How often do you challenge yourself physically?',
    type: 'scale',
    scaleAttributes: {'Strength': 1, 'Constitution': 1},
    scaleLabels: {
      1: 'Rarely',
      2: 'Sometimes',
      3: 'Regularly',
    },
  ),

  Question(
    id: 6,
    text: 'How comfortable are you in social situations?',
    type: 'scale',
    scaleAttributes: {'Charisma': 2},
    scaleLabels: {
      1: 'Reserved',
      2: 'Balanced',
      3: 'Outgoing',
    },
  ),

  // Single choice for problem-solving
  Question(
    id: 7,
    text: 'How do you approach challenges?',
    type: 'single',
    options: [
      'Analyze carefully',
      'Trust your instincts',
      'Get advice',
      'Learn by doing',
    ],
    attributes: {
      'Analyze carefully': {'Intelligence': 2, 'Wisdom': 1},
      'Trust your instincts': {'Wisdom': 2},
      'Get advice': {'Charisma': 2},
      'Learn by doing': {'Dexterity': 2},
    },
  ),

  // Multiple choice for aspirations
  Question(
    id: 8,
    text: 'What would you like to improve about yourself?',
    type: 'multiple',
    options: [
      'Physical fitness',
      'Mental abilities',
      'Social connections',
      'Inner peace',
    ],
    attributes: {
      'Physical fitness': {'Strength': 1, 'Constitution': 1},
      'Mental abilities': {'Intelligence': 2},
      'Social connections': {'Charisma': 2},
      'Inner peace': {'Wisdom': 2},
    },
  ),
];