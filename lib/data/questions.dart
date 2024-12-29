import '../models/question.dart';

final List<Question> quizQuestions = [
  // First 6 existing questions remain the same...

  // Adding scale questions
  Question(
    id: 7,
    text: 'Do you enjoy working out?',
    type: 'scale',
    scaleAttributes: {'Strength': 1},
  ),
  Question(
    id: 8,
    text: 'Do you like meeting new people?',
    type: 'scale',
    scaleAttributes: {'Charisma': 1},
  ),
  Question(
    id: 9,
    text: 'Do you keep up with the news?',
    type: 'scale',
    scaleAttributes: {'Wisdom': 1},
  ),
  Question(
    id: 10,
    text: 'Do you seek out new experiences?',
    type: 'scale',
    scaleAttributes: {'Intelligence': 1},
  ),
  Question(
    id: 11,
    text: 'Do you enjoy playing sports?',
    type: 'scale',
    scaleAttributes: {'Dexterity': 1},
  ),
  Question(
    id: 12,
    text: 'How often do you prioritize your health?',
    type: 'scale',
    scaleAttributes: {'Constitution': 1},
  ),
];