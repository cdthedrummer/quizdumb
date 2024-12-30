import '../models/question.dart';

final quizQuestions = [
  // First 4 questions (Single Choice - more distinct and emotionally engaging)
  Question(
    id: 1,
    text: "You're having a rough day. What helps you bounce back? 🌟",
    type: 'single',
    options: [
      "Solo gym session 💪",
      "Deep chat with a friend 💭",
      "Getting lost in a book 📚",
      "Creating something new 🎨"
    ],
    attributes: {
      "Solo gym session 💪": {'Strength': 2, 'Constitution': 1},
      "Deep chat with a friend 💭": {'Charisma': 2, 'Wisdom': 1},
      "Getting lost in a book 📚": {'Intelligence': 2, 'Wisdom': 1},
      "Creating something new 🎨": {'Dexterity': 2, 'Intelligence': 1},
    },
  ),
  Question(
    id: 2,
    text: "Your perfect Saturday morning looks like... ☀️",
    type: 'single',
    options: [
      "Early workout & protein shake 🏃",
      "Coffee shop people watching ☕",
      "Learning something fascinating 🧠",
      "Exploring somewhere new 🗺️"
    ],
    attributes: {
      "Early workout & protein shake 🏃": {'Strength': 2, 'Constitution': 1},
      "Coffee shop people watching ☕": {'Charisma': 2, 'Wisdom': 1},
      "Learning something fascinating 🧠": {'Intelligence': 2, 'Wisdom': 1},
      "Exploring somewhere new 🗺️": {'Dexterity': 2, 'Wisdom': 1},
    },
  ),
  Question(
    id: 3,
    text: "When life throws you a curveball... 🎯",
    type: 'single',
    options: [
      "Take action right away 👊",
      "Talk it through with others 🤝",
      "Research all the options 🔍",
      "Trust your instincts ⭐"
    ],
    attributes: {
      "Take action right away 👊": {'Strength': 2, 'Dexterity': 1},
      "Talk it through with others 🤝": {'Charisma': 2, 'Wisdom': 1},
      "Research all the options 🔍": {'Intelligence': 2, 'Wisdom': 1},
      "Trust your instincts ⭐": {'Wisdom': 2, 'Dexterity': 1},
    },
  ),
  Question(
    id: 4,
    text: "What makes you lose track of time? ⏰",
    type: 'single',
    options: [
      "Getting in the zone (sports/exercise) 🏃",
      "Deep conversations 💭",
      "Solving puzzles 🧩",
      "Making things with your hands 🛠️"
    ],
    attributes: {
      "Getting in the zone (sports/exercise) 🏃": {'Strength': 2, 'Constitution': 1},
      "Deep conversations 💭": {'Charisma': 2, 'Wisdom': 1},
      "Solving puzzles 🧩": {'Intelligence': 2, 'Dexterity': 1},
      "Making things with your hands 🛠️": {'Dexterity': 2, 'Intelligence': 1},
    },
  ),

  // Scale Questions (Middle 4)
  Question(
    id: 5,
    text: "How often do you get moving? 💪",
    type: 'scale',
    scaleAttributes: {
      'Strength': 2,
      'Constitution': 1,
    },
    scaleLabels: {
      1: "Rarely",
      4: "Sometimes",
      7: "All the time",
    },
  ),
  Question(
    id: 6,
    text: "How do you feel about meeting new people? 🤝",
    type: 'scale',
    scaleAttributes: {
      'Charisma': 2,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: "Rather not",
      4: "It's fine",
      7: "Love it",
    },
  ),
  Question(
    id: 7,
    text: "How often do you try new things? 🌟",
    type: 'scale',
    scaleAttributes: {
      'Dexterity': 1,
      'Intelligence': 1,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: "Rarely",
      4: "Sometimes",
      7: "Often",
    },
  ),
  Question(
    id: 8,
    text: "How's your self-care game? ❤️",
    type: 'scale',
    scaleAttributes: {
      'Constitution': 2,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: "Needs work",
      4: "Not bad",
      7: "On point",
    },
  ),

  // Multiple Choice Questions (Last 4)
  Question(
    id: 9,
    text: "Pick your stress-busters! 😌",
    type: 'multiple',
    options: [
      "Get moving 🏃",
      "Chill out 🧘",
      "See friends 👥",
      "Do hobbies 🎨"
    ],
    attributes: {
      "Get moving 🏃": {'Strength': 1, 'Constitution': 1},
      "Chill out 🧘": {'Wisdom': 1, 'Constitution': 1},
      "See friends 👥": {'Charisma': 2},
      "Do hobbies 🎨": {'Dexterity': 1, 'Intelligence': 1},
    },
  ),
  Question(
    id: 10,
    text: "What gets you excited? 🤔",
    type: 'multiple',
    options: [
      "Sports 🏃",
      "Creating 🎨",
      "Tech stuff 💻",
      "Nature walks 🌿"
    ],
    attributes: {
      "Sports 🏃": {'Strength': 1, 'Dexterity': 1},
      "Creating 🎨": {'Dexterity': 1, 'Intelligence': 1},
      "Tech stuff 💻": {'Intelligence': 2},
      "Nature walks 🌿": {'Constitution': 1, 'Wisdom': 1},
    },
  ),
  Question(
    id: 11,
    text: "Perfect weekend plans? 🎯",
    type: 'multiple',
    options: [
      "Adventure time 🏃",
      "Relaxing 😌",
      "Learn stuff 📚",
      "Friend hangs 🤝"
    ],
    attributes: {
      "Adventure time 🏃": {'Strength': 1, 'Dexterity': 1},
      "Relaxing 😌": {'Constitution': 1, 'Wisdom': 1},
      "Learn stuff 📚": {'Intelligence': 2},
      "Friend hangs 🤝": {'Charisma': 2},
    },
  ),
  Question(
    id: 12,
    text: "Want to level up in... ⬆️",
    type: 'multiple',
    options: [
      "Fitness 💪",
      "People skills 👥",
      "Creative stuff 🎨",
      "Brain power 🧠"
    ],
    attributes: {
      "Fitness 💪": {'Strength': 1, 'Constitution': 1},
      "People skills 👥": {'Charisma': 2},
      "Creative stuff 🎨": {'Dexterity': 1, 'Intelligence': 1},
      "Brain power 🧠": {'Intelligence': 1, 'Wisdom': 1},
    },
  ),
];