import React, { useState } from 'react';
import { questions } from '../data/questions';
import QuestionCard from './QuestionCard';
import type { QuestionOption } from '../data/questions';

const Quiz = () => {
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<number, QuestionOption>>({});

  const handleAnswer = (option: QuestionOption) => {
    console.log('Selected answer:', option); // Debug log
    setAnswers(prev => ({
      ...prev,
      [currentQuestionIndex]: option
    }));
  };

  const handleNext = () => {
    console.log('Current index:', currentQuestionIndex); // Debug log
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
    }
  };

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1);
    }
  };

  const currentQuestion = questions[currentQuestionIndex];
  const progress = ((currentQuestionIndex + 1) / questions.length) * 100;

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-b from-purple-500 to-pink-500 p-4">
      <div className="w-full max-w-md bg-white rounded-lg shadow-xl p-6">
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

        <QuestionCard
          question={currentQuestion}
          selectedOption={answers[currentQuestionIndex]}
          onAnswer={handleAnswer}
        />
        
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