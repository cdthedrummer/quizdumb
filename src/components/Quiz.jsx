import React, { useState } from 'react';

const Quiz = () => {
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});

  const questions = [
    {
      id: 1,
      text: "How do you prefer to learn?",
      type: "single",
      options: [
        { text: "Reading or Studying", attributes: ["intelligence"] },
        { text: "Watching a Video", attributes: ["intelligence", "wisdom"] },
        { text: "Doing it Yourself", attributes: ["dexterity"] },
        { text: "Group Setting", attributes: ["charisma"] }
      ]
    }
  ];

  const handleAnswer = (option) => {
    setAnswers({
      ...answers,
      [currentQuestionIndex]: option
    });
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

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-b from-purple-500 to-pink-500 p-4">
      <div className="w-full max-w-md bg-white rounded-lg shadow-xl p-6">
        <div className="mb-4">
          <div className="h-2 bg-gray-200 rounded">
            <div 
              className="h-full bg-purple-500 rounded transition-all duration-300"
              style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
            />
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
              className={`w-full p-4 text-left rounded-lg transition-all duration-200 ${
                answers[currentQuestionIndex]?.text === option.text
                  ? 'bg-purple-500 text-white'
                  : 'bg-gray-100 hover:bg-gray-200 text-gray-800'
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
            className={`px-6 py-2 rounded-lg ${
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
            className={`px-6 py-2 rounded-lg ${
              !answers[currentQuestionIndex]
                ? 'bg-gray-300 cursor-not-allowed'
                : 'bg-purple-500 hover:bg-purple-600 text-white'
            }`}
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
};

export default Quiz;