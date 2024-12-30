import '../models/question.dart';

final List<Question> questions = [
  Question(
    id: 1,
    text: "You find yourself regularly taking the lead in group situations",
    type: 'scale',
    scaleAttributes: {
      'Charisma': 2,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: 'Strongly Disagree',
      4: 'Neutral',
      7: 'Strongly Agree',
    },
  ),
  Question(
    id: 2,
    text: "How do you prefer to recharge and take care of yourself?",
    type: 'multiple',
    options: [
      "Intense physical workouts",
      "Quiet time for reflection",
      "Social activities with friends",
      "Learning new skills or topics"
    ],
    attributes: {
      "Intense physical workouts": {'Strength': 2, 'Constitution': 1},
      "Quiet time for reflection": {'Wisdom': 2, 'Intelligence': 1},
      "Social activities with friends": {'Charisma': 2, 'Constitution': 1},
      "Learning new skills or topics": {'Intelligence': 2, 'Dexterity': 1},
    },
  ),
  Question(
    id: 3,
    text: "You find complex problems more exciting than routine tasks",
    type: 'scale',
    scaleAttributes: {
      'Intelligence': 2,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: 'Strongly Disagree',
      4: 'Neutral',
      7: 'Strongly Agree',
    },
  ),
  Question(
    id: 4,
    text: "When facing challenges, you tend to:",
    type: 'multiple',
    options: [
      "Push through with physical effort",
      "Plan and analyze carefully",
      "Trust your instincts",
      "Seek advice from others"
    ],
    attributes: {
      "Push through with physical effort": {'Strength': 2, 'Constitution': 1},
      "Plan and analyze carefully": {'Intelligence': 2, 'Wisdom': 1},
      "Trust your instincts": {'Wisdom': 2, 'Dexterity': 1},
      "Seek advice from others": {'Charisma': 2, 'Constitution': 1},
    },
  ),
  Question(
    id: 5,
    text: "You regularly seek out new physical challenges and adventures",
    type: 'scale',
    scaleAttributes: {
      'Strength': 1,
      'Dexterity': 1,
      'Constitution': 1,
    },
    scaleLabels: {
      1: 'Strongly Disagree',
      4: 'Neutral',
      7: 'Strongly Agree',
    },
  ),
  Question(
    id: 6,
    text: "Your friends would describe you as someone who:",
    type: 'multiple',
    options: [
      "Is always up for physical activities",
      "Has creative solutions to problems",
      "Gives thoughtful advice",
      "Makes everyone feel welcome"
    ],
    attributes: {
      "Is always up for physical activities": {'Strength': 2, 'Dexterity': 1},
      "Has creative solutions to problems": {'Intelligence': 2, 'Wisdom': 1},
      "Gives thoughtful advice": {'Wisdom': 2, 'Charisma': 1},
      "Makes everyone feel welcome": {'Charisma': 2, 'Constitution': 1},
    },
  ),
  Question(
    id: 7,
    text: "You find it easy to stay focused during long learning sessions",
    type: 'scale',
    scaleAttributes: {
      'Intelligence': 1,
      'Constitution': 1,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: 'Strongly Disagree',
      4: 'Neutral',
      7: 'Strongly Agree',
    },
  ),
  Question(
    id: 8,
    text: "When learning something new, you prefer to:",
    type: 'multiple',
    options: [
      "Jump in and learn by doing",
      "Study the theory first",
      "Watch others and then try",
      "Figure it out with others"
    ],
    attributes: {
      "Jump in and learn by doing": {'Dexterity': 2, 'Strength': 1},
      "Study the theory first": {'Intelligence': 2, 'Wisdom': 1},
      "Watch others and then try": {'Wisdom': 2, 'Dexterity': 1},
      "Figure it out with others": {'Charisma': 2, 'Intelligence': 1},
    },
  ),
  Question(
    id: 9,
    text: "You naturally notice small details others might miss",
    type: 'scale',
    scaleAttributes: {
      'Wisdom': 2,
      'Intelligence': 1,
    },
    scaleLabels: {
      1: 'Strongly Disagree',
      4: 'Neutral',
      7: 'Strongly Agree',
    },
  ),
  Question(
    id: 10,
    text: "What aspects of personal growth interest you most?",
    type: 'multiple',
    options: [
      "Physical fitness and health",
      "Mental challenges and puzzles",
      "Emotional intelligence",
      "Social connections"
    ],
    attributes: {
      "Physical fitness and health": {'Strength': 2, 'Constitution': 1},
      "Mental challenges and puzzles": {'Intelligence': 2, 'Wisdom': 1},
      "Emotional intelligence": {'Wisdom': 2, 'Charisma': 1},
      "Social connections": {'Charisma': 2, 'Constitution': 1},
    },
  ),
];
