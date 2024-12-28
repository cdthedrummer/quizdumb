import React from 'react';
import type { Question, QuestionOption } from '../data/questions';

interface QuestionCardProps {
  question: Question;
  selectedOption?: QuestionOption;
  onAnswer: (option: QuestionOption) => void;
}

const QuestionCard: React.FC<QuestionCardProps> = ({ question, selectedOption, onAnswer }) => {
  return (
    <div className="w-full">
      <h2 className="text-2xl font-bold mb-6 text-center text-gray-800">
        {question.text}
      </h2>
      
      <div className="space-y-4">
        {question.options.map((option, index) => (
          <button
            key={index}
            onClick={() => onAnswer(option)}
            className={`w-full p-4 text-left rounded-lg transition-all duration-300 ${
              selectedOption?.text === option.text
                ? 'bg-purple-500 text-white transform scale-105'
                : 'bg-gray-100 hover:bg-gray-200 text-gray-800 hover:transform hover:scale-102'
            }`}
          >
            {option.text}
          </button>
        ))}
      </div>
    </div>
  );
};

export default QuestionCard;