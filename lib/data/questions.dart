import '../models/question.dart';

const questions = [
  // Single Choice Questions (First 4)
  Question(
    id: "q1",
    text: "Bad day. What helps? 🌟",
    type: QuestionType.single,
    options: [
      "Cook something new 🥘",
      "Play with pets 🐾",
      "Fix something broken 🔧",
      "Go for a drive 🚗",
      "Write it out 📝"
    ],
    attributes: {
      "Cook something new 🥘": {'Dexterity': 1, 'Wisdom': 2},
      "Play with pets 🐾": {'Wisdom': 2, 'Constitution': 1},
      "Fix something broken 🔧": {'Intelligence': 2, 'Dexterity': 1},
      "Go for a drive 🚗": {'Dexterity': 2, 'Constitution': 1},
      "Write it out 📝": {'Intelligence': 1, 'Wisdom': 2},
    },
  ),
  Question(
    id: "q2",
    text: "Your dream superpower? ✨",
    type: QuestionType.single,
    options: [
      "Time control ⌛",
      "Talk to animals 🦊",
      "Weather control 🌪️",
      "Heal others 💖"
    ],
    attributes: {
      "Time control ⌛": {'Intelligence': 2, 'Wisdom': 1},
      "Talk to animals 🦊": {'Wisdom': 2, 'Charisma': 1},
      "Weather control 🌪️": {'Strength': 2, 'Constitution': 1},
      "Heal others 💖": {'Wisdom': 2, 'Constitution': 1},
    },
  ),
  Question(
    id: "q3",
    text: "Pick a hobby you've never tried 🎯",
    type: QuestionType.single,
    options: [
      "Beekeeping 🐝",
      "Stand-up comedy 🎤",
      "Pottery 🏺",
      "Sky diving 🪂",
      "Gardening 🌱",
      "Cooking class 👨‍🍳"
    ],
    attributes: {
      "Beekeeping 🐝": {'Wisdom': 2, 'Constitution': 1},
      "Stand-up comedy 🎤": {'Charisma': 2, 'Intelligence': 1},
      "Pottery 🏺": {'Dexterity': 2, 'Wisdom': 1},
      "Sky diving 🪂": {'Strength': 1, 'Constitution': 2},
      "Gardening 🌱": {'Constitution': 2, 'Wisdom': 1},
      "Cooking class 👨‍🍳": {'Dexterity': 1, 'Charisma': 2},
    },
  ),
  Question(
    id: "q4",
    text: "It's raining. You've got the day off. You... ☔",
    type: QuestionType.single,
    options: [
      "Build a blanket fort 🏰",
      "Bake cookies 🍪",
      "Call old friends 📞",
      "Take photos 📸",
      "Nap time 😴"
    ],
    attributes: {
      "Build a blanket fort 🏰": {'Dexterity': 1, 'Intelligence': 2},
      "Bake cookies 🍪": {'Dexterity': 2, 'Constitution': 1},
      "Call old friends 📞": {'Charisma': 2, 'Wisdom': 1},
      "Take photos 📸": {'Dexterity': 1, 'Wisdom': 2},
      "Nap time 😴": {'Constitution': 2, 'Wisdom': 1},
    },
  ),

  // Scale Questions (Middle 4)
  Question(
    id: "q5",
    text: "How do you handle change? 🔄",
    type: QuestionType.scale,
    scaleAttributes: {
      'Wisdom': 2,
      'Constitution': 1,
    },
    scaleLabels: {
      1: "Avoid it",
      4: "Roll with it",
      7: "Bring it on",
    },
  ),
  Question(
    id: "q6",
    text: "Do you collect things? 🗃️",
    type: QuestionType.scale,
    scaleAttributes: {
      'Intelligence': 2,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: "Nope",
      4: "A few things",
      7: "Big collector",
    },
  ),

  Question(
    id: "q7",
    text: "How's your green thumb? 🌱",
    type: QuestionType.scale,
    scaleAttributes: {
      'Constitution': 2,
      'Wisdom': 1,
    },
    scaleLabels: {
      1: "Plant killer",
      4: "Some alive",
      7: "Plant whisperer",
    },
  ),
  Question(
    id: "q8",
    text: "Morning person? 🌅",
    type: QuestionType.scale,
    scaleAttributes: {
      'Constitution': 2,
      'Strength': 1,
    },
    scaleLabels: {
      1: "Night owl",
      4: "Depends",
      7: "Early bird",
    },
  ),

  // Multiple Choice Questions (Last 4)
  Question(
    id: "q9",
    text: "Pick your perfect pets! 🐾",
    type: QuestionType.multiple,
    options: [
      "Dog 🐕",
      "Cat 🐱",
      "Fish 🐠",
      "Bird 🦜",
      "Reptile 🦎",
      "Rabbit 🐰"
    ],
    attributes: {
      "Dog 🐕": {'Strength': 1, 'Charisma': 1},
      "Cat 🐱": {'Wisdom': 2},
      "Fish 🐠": {'Intelligence': 1, 'Constitution': 1},
      "Bird 🦜": {'Charisma': 2},
      "Reptile 🦎": {'Constitution': 2},
      "Rabbit 🐰": {'Dexterity': 1, 'Wisdom': 1},
    },
  ),
  Question(
    id: "q10",
    text: "What would you save in a fire? 🔥",
    type: QuestionType.multiple,
    options: [
      "Photo albums 📸",
      "Family heirlooms 👑",
      "Favorite clothes 👕",
      "Electronics 📱",
      "Art supplies 🎨"
    ],
    attributes: {
      "Photo albums 📸": {'Wisdom': 2},
      "Family heirlooms 👑": {'Wisdom': 1, 'Constitution': 1},
      "Favorite clothes 👕": {'Charisma': 2},
      "Electronics 📱": {'Intelligence': 2},
      "Art supplies 🎨": {'Dexterity': 2},
    },
  )
];