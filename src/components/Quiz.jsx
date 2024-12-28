import React, { useState } from 'react';

const Quiz = () => {
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [showEncouragement, setShowEncouragement] = useState(false);

  const questions = [
    {
      id: 1,
      text: "When facing a challenge, I typically...",
      type: "single",
      options: [
        { text: "Plan every detail before starting", attributes: ["intelligence"] },
        { text: "Trust my instincts and dive in", attributes: ["wisdom"] },
        { text: "Get hands-on and learn by doing", attributes: ["dexterity"] },
        { text: "Rally others to help tackle it", attributes: ["charisma"] }
      ]
    },
    {
      id: 2,
      text: "I feel most energized when I'm...",
      type: "single",
      options: [
        { text: "Pushing my physical limits", attributes: ["strength", "constitution"] },
        { text: "Solving complex problems", attributes: ["intelligence"] },
        { text: "Creating or performing", attributes: ["charisma", "dexterity"] },
        { text: "Helping others grow", attributes: ["wisdom", "charisma"] }
      ]
    },
    {
      id: 3,
      text: "In group situations, I naturally tend to...",
      type: "single",
      options: [
        { text: "Take charge and direct", attributes: ["strength", "charisma"] },
        { text: "Analyze and advise", attributes: ["intelligence", "wisdom"] },
        { text: "Support and harmonize", attributes: ["wisdom", "charisma"] },
        { text: "Energize and motivate", attributes: ["charisma", "dexterity"] }
      ]
    },
    {
      id: 4,
      text: "My ideal way to spend free time is...",
      type: "single",
      options: [
        { text: "Physical activity or sports", attributes: ["strength", "dexterity"] },
        { text: "Learning something new", attributes: ["intelligence", "wisdom"] },
        { text: "Creative expression", attributes: ["dexterity", "charisma"] },
        { text: "Social gatherings", attributes: ["charisma", "constitution"] }
      ]
    },
    {
      id: 5,
      text: "When making important decisions, I rely most on...",
      type: "single",
      options: [
        { text: "Careful analysis", attributes: ["intelligence"] },
        { text: "Past experience", attributes: ["wisdom"] },
        { text: "Gut feeling", attributes: ["constitution"] },
        { text: "Others' input", attributes: ["charisma"] }
      ]
    }
  ];

  const encouragementMessages = [
    "Great choice! Let's keep going!",
    "You're doing great! 🌟",
    "Excellent progress!",
    "Keep it up! Almost there!",
    "Your journey is unfolding!"
  ];

  const handleAnswer = (option) => {
    setAnswers({
      ...answers,
      [currentQuestionIndex]: option
    });
    setShowEncouragement(true);
    setTimeout(() => {
      setShowEncouragement(false);
    }, 1000);
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    }
  };

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
    }
  };

  const currentQuestion = questions[currentQuestionIndex];
  const progress = ((currentQuestionIndex + 1) / questions.length) * 100;

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-b from-purple-500 to-pink-500 p-4">
      <div className="w-full max-w-md bg-white rounded-lg shadow-xl p-6 relative">
        {showEncouragement && (
          <div className="absolute top-0 left-0 right-0 text-center -mt-8 text-white font-bold text-lg animate-bounce">
            {encouragementMessages[Math.floor(Math.random() * encouragementMessages.length)]}
          </div>
        )}
        
        <div className="mb-6">
          <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
            <div 
              className="h-full bg-purple-500 transition-all duration-500 ease-out"
              style={{ width: `${progress}%` }}
            />
          </div>
          <div className="text-center text-sm text-gray-600 mt-2">
            Question {currentQuestionIndex + 1} of {questions.length}
          </div>
        </div>
        
        <h2 className="text-2xl font-bold mb-6 text-center text-gray-800">
          {currentQuestion.text}
        </h2>
        
        <div className="space-y-4">
          {currentQuestion.options.map((option, index) => (
            <button
              key={index}
              onClick={() => handleAnswer(option)}
              className={`w-full p-4 text-left rounded-lg transition-all duration-300 ${
                answers[currentQuestionIndex]?.text === option.text
                  ? 'bg-purple-500 text-white transform scale-105'
                  : 'bg-gray-100 hover:bg-gray-200 text-gray-800 hover:transform hover:scale-102'
              }`}
            >
              {option.text}
            </button>
          ))}
        </div>
        
        <div className="flex justify-between mt-8">
          <button
            onClick={handlePrevious}
            disabled={currentQuestionIndex === 0}
            className={`px-6 py-2 rounded-lg transition-all duration-300 ${
              currentQuestionIndex === 0
                ? 'bg-gray-300 cursor-not-allowed'
                : 'bg-purple-500 hover:bg-purple-600 text-white'
            }`}
          >
            Previous
          </button>
          
          <button
            onClick={handleNext}
            disabled={!answers[currentQuestionIndex]}
            className={`px-6 py-2 rounded-lg transition-all duration-300 ${
              !answers[currentQuestionIndex]
                ? 'bg-gray-300 cursor-not-allowed'
                : 'bg-purple-500 hover:bg-purple-600 text-white'
            }`}
          >
            {currentQuestionIndex === questions.length - 1 ? 'See Results' : 'Next'}
          </button>
        </div>
      </div>
    </div>
  );
};

export default Quiz;