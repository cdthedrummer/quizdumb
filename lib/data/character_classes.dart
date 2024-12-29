import '../models/character_class.dart';

final List<CharacterClass> characterClasses = [
  // Intelligence Primary
  CharacterClass(
    name: 'Wizard',
    title: 'The Seeker of Knowledge',
    emoji: '🧙‍♂️',
    description: 'You are an intellectual powerhouse with an unquenchable thirst for knowledge. Your analytical mind and love for learning make you a natural problem solver and innovator.',
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
      'Explore new technologies or programming languages',
      'Participate in academic discussions or forums',
    ],
  ),

  // Dexterity Primary
  CharacterClass(
    name: 'Rogue',
    title: 'The Virtuoso',
    emoji: '🎭',
    description: 'Your natural agility and quick thinking make you adaptable and resourceful. You excel at finding creative solutions and navigating complex situations with grace.',
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
      'Practice photography or other precise arts',
    ],
  ),

  // Wisdom Primary
  CharacterClass(
    name: 'Druid',
    title: 'The Naturalist',
    emoji: '🌿',
    description: 'Your deep connection with the world around you gives you unique insights. You understand the delicate balance of life and have a natural ability to find harmony.',
    primaryStat: 'Wisdom',
    secondaryStat: 'Constitution',
    minimumStats: {
      'Wisdom': 7,
      'Constitution': 5,
    },
    keyTraits: [
      'Strong intuition and perception',
      'Deep understanding of natural cycles',
      'Balanced perspective on life',
      'Ability to find peace in chaos',
    ],
    growthAreas: [
      'Share wisdom with those who need guidance',
      'Apply insights to practical situations',
      'Maintain balance between solitude and community',
    ],
    suggestedActivities: [
      'Practice meditation or yoga',
      'Study herbalism or gardening',
      'Volunteer at environmental organizations',
      'Lead nature walks or outdoor activities',
    ],
  ),

  // Strength Primary
  CharacterClass(
    name: 'Warrior',
    title: 'The Champion',
    emoji: '⚔️',
    description: 'Your physical prowess and determination make you a natural leader in challenging situations. You have the power to overcome obstacles and inspire others.',
    primaryStat: 'Strength',
    secondaryStat: 'Constitution',
    minimumStats: {
      'Strength': 7,
      'Constitution': 5,
    },
    keyTraits: [
      'Natural physical strength',
      'Unwavering determination',
      'Leadership in challenging situations',
      'Protective instincts',
    ],
    growthAreas: [
      'Balance physical strength with emotional awareness',
      'Learn to handle delicate situations',
      'Develop strategic thinking skills',
    ],
    suggestedActivities: [
      'Join a sports team or fitness class',
      'Take up weightlifting or CrossFit',
      'Learn self-defense techniques',
      'Participate in team-building activities',
    ],
  ),

  // Charisma Primary
  CharacterClass(
    name: 'Bard',
    title: 'The Performer',
    emoji: '🎸',
    description: 'Your natural charm and creativity make you the life of any gathering. You have the power to inspire and bring joy to others through your natural expressiveness.',
    primaryStat: 'Charisma',
    secondaryStat: 'Dexterity',
    minimumStats: {
      'Charisma': 7,
      'Dexterity': 5,
    },
    keyTraits: [
      'Natural leadership and charm',
      'Creative expression',
      'Ability to inspire others',
      'Strong communication skills',
    ],
    growthAreas: [
      'Develop depth beyond surface charm',
      'Listen as much as you perform',
      'Channel creativity into structured goals',
    ],
    suggestedActivities: [
      'Join a theater group or improv class',
      'Start a podcast or YouTube channel',
      'Take public speaking courses',
      'Learn storytelling techniques',
    ],
  ),

  // Constitution Primary
  CharacterClass(
    name: 'Paladin',
    title: 'The Guardian',
    emoji: '🛡️',
    description: 'Your resilience and strong moral compass make you a pillar of strength for others. You have the endurance to stand firm in your beliefs and protect what matters.',
    primaryStat: 'Constitution',
    secondaryStat: 'Charisma',
    minimumStats: {
      'Constitution': 7,
      'Charisma': 5,
    },
    keyTraits: [
      'Exceptional endurance and resilience',
      'Strong moral principles',
      'Protective of others',
      'Natural leadership abilities',
    ],
    growthAreas: [
      'Balance tradition with innovation',
      'Learn to adapt to changing situations',
      'Develop flexibility in viewpoints',
    ],
    suggestedActivities: [
      'Train for a marathon or triathlon',
      'Volunteer for community service',
      'Learn about health and wellness',
      'Practice meditation and mindfulness',
    ],
  ),

  // Special: Well-Rounded
  CharacterClass(
    name: 'Jack of All Trades',
    title: 'The Renaissance Soul',
    emoji: '🎯',
    description: 'Your balanced abilities make you uniquely adaptable. You can succeed in any situation by drawing from your diverse set of skills and experiences.',
    primaryStat: 'Balanced',
    secondaryStat: 'Balanced',
    minimumStats: {
      'Strength': 4,
      'Dexterity': 4,
      'Constitution': 4,
      'Intelligence': 4,
      'Wisdom': 4,
      'Charisma': 4,
    },
    keyTraits: [
      'Exceptional adaptability',
      'Broad skill set',
      'Quick learning abilities',
      'Versatile problem-solving',
    ],
    growthAreas: [
      'Focus on developing expertise in key areas',
      'Channel versatility into specific goals',
      'Find balance between breadth and depth',
    ],
    suggestedActivities: [
      'Try new hobbies regularly',
      'Join varied interest groups',
      'Create cross-disciplinary projects',
      'Teach others your diverse skills',
    ],
  ),
];