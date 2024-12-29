final List<Map<String, dynamic>> quizQuestions = [
  {
    'id': 1,
    'text': 'How do you prefer to learn?',
    'options': ['Reading', 'Watching', 'Doing', 'Group'],
    'type': 'single',
    'attributes': {
      'Reading': {'Intelligence': 2, 'Wisdom': 1},
      'Watching': {'Wisdom': 2, 'Intelligence': 1},
      'Doing': {'Dexterity': 2, 'Strength': 1},
      'Group': {'Charisma': 2, 'Wisdom': 1},
    },
  },
  {
    'id': 2,
    'text': "Where's your focus when it comes to being healthy?",
    'options': ['Eating Well', 'Being Active', 'Relaxing', 'Regular Check-ups'],
    'type': 'multiple',
    'attributes': {
      'Eating Well': {'Constitution': 2},
      'Being Active': {'Strength': 1, 'Dexterity': 1},
      'Relaxing': {'Wisdom': 1},
      'Regular Check-ups': {'Constitution': 2},
    },
  },
  {
    'id': 3,
    'text': 'What kind of physical activity makes you the happiest?',
    'options': ['Outdoor Adventures', 'Team Sports', 'Solo Workouts', 'Fun Activities'],
    'type': 'single',
    'attributes': {
      'Outdoor Adventures': {'Constitution': 2, 'Wisdom': 1},
      'Team Sports': {'Charisma': 2, 'Dexterity': 1},
      'Solo Workouts': {'Strength': 2},
      'Fun Activities': {'Dexterity': 2, 'Charisma': 1},
    },
  },
  {
    'id': 4,
    'text': 'What makes you feel the most energized?',
    'options': ['Challenging Yourself', 'Socializing', 'Quiet Time', 'Creating'],
    'type': 'single',
    'attributes': {
      'Challenging Yourself': {'Strength': 1, 'Dexterity': 1},
      'Socializing': {'Charisma': 2},
      'Quiet Time': {'Wisdom': 2},
      'Creating': {'Intelligence': 2},
    },
  },
  {
    'id': 5,
    'text': 'How do you like to recharge?',
    'options': ['Nature', 'Games', 'Entertainment', 'Music'],
    'type': 'multiple',
    'attributes': {
      'Nature': {'Constitution': 1, 'Wisdom': 1},
      'Games': {'Intelligence': 2},
      'Entertainment': {'Charisma': 1},
      'Music': {'Wisdom': 2},
    },
  },
];