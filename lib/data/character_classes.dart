import '../models/character_class.dart';

const characterClasses = [
  CharacterClass(
    name: 'The Problem Solver',
    emoji: '🧩',
    description: 'You thrive on finding solutions and thinking outside the box. Your analytical mind and creativity make you a natural innovator.',
    attributeWeights: {
      'Intelligence': 2.0,
      'Wisdom': 1.5,
      'Dexterity': 1.0,
    },
    recommendations: [
      'Learn a new programming language',
      'Try puzzle-solving games',
      'Join a maker community',
      'Take a design thinking course',
    ],
  ),

  CharacterClass(
    name: 'The Adventurer',
    emoji: '🌟',
    description: 'You seek new experiences and challenges. Your courage and adaptability make every day an opportunity for growth.',
    attributeWeights: {
      'Constitution': 2.0,
      'Strength': 1.5,
      'Charisma': 1.0,
    },
    recommendations: [
      'Try a new outdoor sport',
      'Plan a solo trip',
      'Join an adventure club',
      'Learn survival skills',
    ],
  ),

  CharacterClass(
    name: 'The Empath',
    emoji: '💖',
    description: 'You excel at understanding and connecting with others. Your emotional intelligence and compassion make you a natural leader.',
    attributeWeights: {
      'Charisma': 2.0,
      'Wisdom': 1.5,
      'Constitution': 1.0,
    },
    recommendations: [
      'Practice active listening',
      'Volunteer in your community',
      'Take a counseling course',
      'Start a support group',
    ],
  ),

  CharacterClass(
    name: 'The Craftsperson',
    emoji: '🎨',
    description: 'You have a natural talent for creating and making things. Your patience and attention to detail produce amazing results.',
    attributeWeights: {
      'Dexterity': 2.0,
      'Intelligence': 1.5,
      'Constitution': 1.0,
    },
    recommendations: [
      'Start a DIY project',
      'Take an art class',
      'Learn woodworking',
      'Try digital design',
    ],
  ),

  CharacterClass(
    name: 'The Scholar',
    emoji: '📚',
    description: 'You have an unquenchable thirst for knowledge. Your curiosity and dedication make you a lifelong learner.',
    attributeWeights: {
      'Intelligence': 2.0,
      'Wisdom': 1.5,
      'Charisma': 1.0,
    },
    recommendations: [
      'Start a research project',
      'Join a book club',
      'Take online courses',
      'Learn a new language',
    ],
  ),
];