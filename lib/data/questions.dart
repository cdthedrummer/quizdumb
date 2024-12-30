import '../models/question.dart';

final quizQuestions = [
  Question(
    id: 1,
    text: "You find yourself energized after teaching others something new",
    type: 'scale',
    scaleAttributes: {
      'Intelligence': 1,
      'Charisma': 1,
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
    text: "Which activities help you unwind after a long day?",
    type: 'multiple',
    options: [
      "Working out or physical activity",
      "Reading or learning something new",
      "Spending time with friends",
      "Quiet reflection or meditation"
    ],
    attributes: {
      "Working out or physical activity": {'Strength': 2, 'Constitution': 1},
      "Reading or learning something new": {'Intelligence': 2, 'Wisdom': 1},
      "Spending time with friends": {'Charisma': 2, 'Wisdom': 1},
      "Quiet reflection or meditation": {'Wisdom': 2, 'Constitution': 1},
    },
  ),
  // ... rest of the questions remain the same
];
