import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const Quiz = () => {
  const navigate = useNavigate();
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  
  // Test questions array
  const questions = [
    {
      id: 1,
      text: "How do you prefer to learn?",
      options: ["Reading", "Watching", "Doing", "Group"]
    },
    {
      id: 2,
      text: "What energizes you most?",
      options: ["Physical challenges", "Mental puzzles", "Creative expression", "Helping others"]
    }
  ];

  useEffect(() => {
    console.log('Quiz component mounted');
    console.log('Current question index:', currentQuestionIndex);
  }, [currentQuestionIndex]);

  const handleOptionClick = (option: string) => {
    console.log('Option clicked:', option);
    setAnswers(prev => ({
      ...prev,
      [currentQuestionIndex]: option
    }));
  };

  const handleNext = () => {
    console.log('Next clicked, current index:', currentQuestionIndex);
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => {
        console.log('Setting new index to:', prev + 1);
        return prev + 1;
      });
    } else {
      console.log('Quiz complete!');
      // navigate('/results');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-500 to-pink-500 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg p-6 w-full max-w-md">
        <div className="mb-4 bg-gray-200 rounded-full h-2">
          <div 
            className="h-2 bg-purple-500 rounded-full transition-all duration-300"
            style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
          />
        </div>

        <h2 className="text-2xl font-bold mb-6">
          {questions[currentQuestionIndex].text}
        </h2>

        <div className="space-y-3">
          {questions[currentQuestionIndex].options.map((option, idx) => (
            <button
              key={idx}
              onClick={() => {
                console.log('Button clicked:', option);
                handleOptionClick(option);
              }}
              className="w-full p-4 text-left rounded-lg bg-gray-100 hover:bg-purple-100 transition-colors duration-200"
            >
              {option}
            </button>
          ))}
        </div>

        <div className="mt-6 flex justify-end">
          <button
            onClick={handleNext}
            className="px-6 py-2 bg-purple-500 text-white rounded-lg hover:bg-purple-600 transition-colors duration-200"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
};

export default Quiz;