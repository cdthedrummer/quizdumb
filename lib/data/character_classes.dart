import '../models/character_class.dart';

final List<CharacterClass> characterClasses = [
  // Intelligence Primary
  CharacterClass(
    name: 'Wizard',
    title: 'The Seeker of Knowledge',
    emoji: '🧙‍♂️',
    description: 'You are an **intellectual powerhouse** with an **unquenchable thirst** for knowledge. Your **analytical mind** and **love for learning** make you a natural **problem solver** and **innovator**.',
    primaryStat: 'Intelligence',
    secondaryStat: 'Wisdom',
    minimumStats: {
      'Intelligence': 7,
      'Wisdom': 5,
    },
    keyTraits: [
      'Exceptional problem-solving abilities',
      'Strong analytical thinking',
      'Love for learning and research',
      'Innovative approaches to challenges',
    ],
    growthAreas: [
      'Balance theoretical knowledge with practical application',
      'Take time to share knowledge with others',
      'Remember to take breaks from intense study',
    ],
    suggestedActivities: [
      'Join a coding bootcamp or workshop',
      'Take up chess or strategic games',
      'Explore new technologies',
      'Participate in academic discussions',
    ],
  ),

  // Dexterity Primary
  CharacterClass(
    name: 'Rogue',
    title: 'The Virtuoso',
    emoji: '🎭',
    description: 'Your **natural agility** and **quick thinking** make you **adaptable** and **resourceful**. You excel at finding **creative solutions** and navigating complex situations with **grace**.',
    primaryStat: 'Dexterity',
    secondaryStat: 'Charisma',
    minimumStats: {
      'Dexterity': 7,
      'Charisma': 5,
    },
    keyTraits: [
      'Exceptional coordination and reflexes',
      'Quick thinking and adaptability',
      'Creative problem-solving',
      'Natural grace under pressure',
    ],
    growthAreas: [
      'Build trust through transparency',
      'Channel skills into constructive pursuits',
      'Develop long-term planning abilities',
    ],
    suggestedActivities: [
      'Take up dance or martial arts',
      'Try rock climbing or parkour',
      'Learn a musical instrument',
      'Practice photography',
    ],
  ),

  // Added more D&D-inspired classes
  CharacterClass(
    name: 'Barbarian',
    title: 'The Primal Force',
    emoji: '⚔️',
    description: 'Your **raw power** and **fierce determination** make you an **unstoppable force**. You possess **natural strength** and **endurance** that few can match.',
    primaryStat: 'Strength',
    secondaryStat: 'Constitution',
    minimumStats: {
      'Strength': 7,
      'Constitution': 5,
    },
    keyTraits: [
      'Extraordinary physical strength',
      'Unwavering determination',
      'Natural athletic ability',
      'Raw power in challenges',
    ],
    growthAreas: [
      'Channel strength with precision',
      'Develop patience in complex situations',
      'Balance power with control',
    ],
    suggestedActivities: [
      'Join competitive sports',
      'Take up weightlifting',
      'Practice endurance training',
      'Learn combat sports',
    ],
  ),

  CharacterClass(
    name: 'Monk',
    title: 'The Disciplined Soul',
    emoji: '🥋',
    description: 'Your **perfect balance** of **physical prowess** and **mental discipline** makes you uniquely **adaptable**. You possess both **strength** and **grace** in equal measure.',
    primaryStat: 'Dexterity',
    secondaryStat: 'Strength',
    minimumStats: {
      'Dexterity': 7,
      'Strength': 5,
    },
    keyTraits: [
      'Perfect balance of mind and body',
      'Exceptional self-discipline',
      'Focused determination',
      'Graceful strength',
    ],
    growthAreas: [
      'Share your knowledge with others',
      'Find balance in all aspects of life',
      'Apply discipline to new challenges',
    ],
    suggestedActivities: [
      'Practice martial arts',
      'Take up meditation',
      'Learn acrobatics',
      'Study philosophy',
    ],
  ),

  CharacterClass(
    name: 'Paladin',
    title: 'The Guardian',
    emoji: '🛡️',
    description: 'Your **unwavering resolve** and **protective nature** make you a **pillar of strength** for others. You combine **physical power** with **moral conviction**.',
    primaryStat: 'Constitution',
    secondaryStat: 'Charisma',
    minimumStats: {
      'Constitution': 7,
      'Charisma': 5,
    },
    keyTraits: [
      'Strong moral compass',
      'Natural leadership abilities',
      'Protective instincts',
      'Unwavering determination',
    ],
    growthAreas: [
      'Balance justice with mercy',
      'Learn to adapt to change',
      'Consider multiple perspectives',
    ],
    suggestedActivities: [
      'Volunteer for community service',
      'Lead group activities',
      'Study conflict resolution',
      'Practice public speaking',
    ],
  ),

  // Add more classes as needed...
];