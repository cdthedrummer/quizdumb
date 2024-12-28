export interface QuestionOption {
  text: string;
  attributes: string[];
}

export interface Question {
  id: number;
  text: string;
  type: 'single' | 'multiple' | 'scale';
  options: QuestionOption[];
}

export const questions: Question[] = [
  {
    id: 1,
    text: "How do you prefer to learn?",
    type: "single",
    options: [
      { text: "Reading", attributes: ["intelligence"] },
      { text: "Watching", attributes: ["intelligence", "wisdom"] },
      { text: "Doing", attributes: ["dexterity"] },
      { text: "Group", attributes: ["charisma"] }
    ]
  },
  {
    id: 2,
    text: "What energizes you most?",
    type: "single",
    options: [
      { text: "Physical challenges", attributes: ["strength", "constitution"] },
      { text: "Mental puzzles", attributes: ["intelligence"] },
      { text: "Creative expression", attributes: ["charisma", "dexterity"] },
      { text: "Helping others", attributes: ["wisdom", "charisma"] }
    ]
  },
  {
    id: 3,
    text: "In a crisis, you usually...",
    type: "single",
    options: [
      { text: "Take charge", attributes: ["strength", "charisma"] },
      { text: "Analyze the situation", attributes: ["intelligence", "wisdom"] },
      { text: "Keep people calm", attributes: ["wisdom", "charisma"] },
      { text: "Get hands-on", attributes: ["dexterity", "constitution"] }
    ]
  }
];