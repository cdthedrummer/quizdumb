import 'package:flutter/material.dart';
import 'questions.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  Map<int, dynamic> answers = {};
  Set<String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 32),
              Text(
                questions[currentQuestionIndex].text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Expanded(
                child: _buildQuestionWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget() {
    final question = questions[currentQuestionIndex];
    switch (question.type) {
      case QuestionType.singleChoice:
        return _buildSingleChoiceQuestion(question);
      case QuestionType.slider:
        return _buildSliderQuestion(question);
      case QuestionType.multiSelect:
        return _buildMultiSelectQuestion(question);
    }
  }

  Widget _buildSingleChoiceQuestion(Question question) {
    return ListView.builder(
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20),
              textStyle: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              setState(() {
                answers[currentQuestionIndex] = index;
                if (currentQuestionIndex < questions.length - 1) {
                  currentQuestionIndex++;
                }
              });
            },
            child: Text(question.options[index]),
          ),
        );
      },
    );
  }

  Widget _buildSliderQuestion(Question question) {
    double value = (answers[currentQuestionIndex] ?? 0.0).toDouble();
    return Column(
      children: [
        Slider(
          value: value,
          min: 0,
          max: 3,
          divisions: 3,
          label: question.options[value.round()],
          onChanged: (newValue) {
            setState(() {
              answers[currentQuestionIndex] = newValue;
            });
          },
        ),
        Text(
          question.options[value.round()],
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            if (currentQuestionIndex < questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
              });
            }
          },
          child: Text('Continue'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelectQuestion(Question question) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              final option = question.options[index];
              final isSelected = selectedOptions.contains(option);
              return CheckboxListTile(
                title: Text(
                  option,
                  style: TextStyle(fontSize: 18),
                ),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value ?? false) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }
                    answers[currentQuestionIndex] = List<String>.from(selectedOptions);
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (currentQuestionIndex < questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
                selectedOptions.clear();
              });
            }
          },
          child: Text('Continue'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}