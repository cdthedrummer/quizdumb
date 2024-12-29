import '../models/question.dart';

final List<Question> quizQuestions = [
  Question(
    id: 1,
    text: 'How do you prefer to learn?',
    options: ['Reading', 'Watching', 'Doing', 'Group'],
    type: 'single',
    attributes: {
      'Reading': {'Intelligence': 2, 'Wisdom': 1},
      'Watching': {'Wisdom': 2, 'Intelligence': 1},
      'Doing': {'Dexterity': 2, 'Strength': 1},
      'Group': {'Charisma': 2, 'Wisdom': 1},
    },
  ),
  Question(
    id: 2,
    text: 'Where\'s your focus when it comes to being healthy?',
    options: ['Eating Well', 'Being Active', 'Relaxing', 'Regular Check-ups'],
    type: 'multiple',
    attributes: {
      'Eating Well': {'Constitution': 2},
      'Being Active': {'Strength': 1, 'Dexterity': 1},
      'Relaxing': {'Wisdom': 1},
      'Regular Check-ups': {'Constitution': 2},
    },
  ),
  Question(
    id: 3,
    text: 'What kind of physical activity makes you the happiest?',
    options: ['Outdoor Adventures', 'Team Sports', 'Solo Workouts', 'Fun Activities'],
    type: 'single',
    attributes: {
      'Outdoor Adventures': {'Constitution': 2, 'Wisdom': 1},
      'Team Sports': {'Charisma': 2, 'Dexterity': 1},
      'Solo Workouts': {'Strength': 2},
      'Fun Activities': {'Dexterity': 2, 'Charisma': 1},
    },
  ),
  Question(
    id: 4,
    text: 'What makes you feel the most energized?',
    options: ['Challenging Yourself', 'Hanging with Friends', 'Quiet Time', 'Creating Things'],
    type: 'single',
    attributes: {
      'Challenging Yourself': {'Strength': 1, 'Constitution': 1},
      'Hanging with Friends': {'Charisma': 2},
      'Quiet Time': {'Wisdom': 2},
      'Creating Things': {'Intelligence': 2, 'Dexterity': 1},
    },
  ),
  Question(
    id: 5,
    text: 'How do you like to solve tough problems?',
    options: ['Careful Planning', 'Trial and Error', 'Group Discussion', 'Following Instincts'],
    type: 'single',
    attributes: {
      'Careful Planning': {'Intelligence': 2},
      'Trial and Error': {'Dexterity': 1, 'Constitution': 1},
      'Group Discussion': {'Charisma': 2},
      'Following Instincts': {'Wisdom': 2},
    },
  ),
  Question(
    id: 6,
    text: 'How do you like to recharge?',
    options: ['Nature Time', 'Mental Games', 'Social Activities', 'Meditation'],
    type: 'multiple',
    attributes: {
      'Nature Time': {'Constitution': 1, 'Wisdom': 1},
      'Mental Games': {'Intelligence': 2},
      'Social Activities': {'Charisma': 2},
      'Meditation': {'Wisdom': 2},
    },
  ),
];