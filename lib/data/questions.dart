import '../models/question.dart';

final quizQuestions = [
  // Single Choice Questions (First 4)
  Question(
    id: 1,
    text: "Ready to recharge? Pick your go-to! 🔋",
    type: 'single',
    options: [
      "Power up at the gym 💪",
      "Friend time ☕",
      "Get lost in a book 📚",
      "Make something cool 🎨"
    ],
    attributes: {
      "Power up at the gym 💪": {'Strength': 2, 'Constitution': 1},
      "Friend time ☕": {'Charisma': 2, 'Wisdom': 1},
      "Get lost in a book 📚": {'Intelligence': 2, 'Wisdom': 1},
      "Make something cool 🎨": {'Dexterity': 2, 'Intelligence': 1},
    },
  ),
  Question(
    id: 2,
    text: "Time to have fun! What's your move? 🎉",
    type: 'single',
    options: [
      "Game on! 🏃",
      "Board game night 🎲",
      "Learn something new 🧠",
      "Jam session 🎵"
    ],
    attributes: {
      "Game on! 🏃": {'Dexterity': 2, 'Strength': 1},
      "Board game night 🎲": {'Intelligence': 2, 'Charisma': 1},
      "Learn something new 🧠": {'Intelligence': 2, 'Wisdom': 1},
      "Jam session 🎵": {'Charisma': 2, 'Dexterity': 1},
    },
  ),
  Question(
    id: 3,
    text: "Facing a challenge? What's your style? 💭",
    type: 'single',
    options: [
      "Just do it! 💪",
      "Phone a friend 🤝",
      "Make a plan 📝",
      "Trust your gut 🎯"
    ],
    attributes: {
      "Just do it! 💪": {'Strength': 2, 'Constitution': 1},
      "Phone a friend 🤝": {'Charisma': 2, 'Wisdom': 1},
      "Make a plan 📝": {'Intelligence': 2, 'Wisdom': 1},
      "Trust your gut 🎯": {'Wisdom': 2, 'Dexterity': 1},
    },
  ),
  Question(
    id: 4,
    text: "Best way to pick up something new? 📚",
    type: 'single',
    options: [
      "Jump right in 🏃",
      "Watch the pros 👀",
      "Study up 📖",
      "Learn together 👥"
    ],
    attributes: {
      "Jump right in 🏃": {'Dexterity': 2, 'Strength': 1},
      "Watch the pros 👀": {'Wisdom': 2, 'Intelligence': 1},
      "Study up 📖": {'Intelligence': 2, 'Wisdom': 1},
      "Learn together 👥": {'Charisma': 2, 'Intelligence': 1},
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
      1: 'Rarely',
      4: 'Sometimes',
      7: 'All the time',
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
      1: 'Rather not',
      4: 'It's okay',
      7: 'Love it!',
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
      1: 'Stick to basics',
      4: 'Sometimes',
      7: 'Always game!',
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
      1: 'Could be better',
      4: 'Not bad',
      7: 'On point!',
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