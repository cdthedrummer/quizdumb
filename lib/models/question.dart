import 'package:flutter/material.dart';
import 'category.dart';

enum QuestionType {
  single,
  multiple,
  scale,
  imageChoice,
  priorityRanking
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<String>? options;
  final List<String>? imageOptions;
  final Map<int, String>? scaleLabels;
  final List<Category> categories;
  final Map<Category, double> categoryWeights;
  final String? encouragingMessage;
  final bool isCheckpoint;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.imageOptions,
    this.scaleLabels,
    this.categories = const [],
    this.categoryWeights = const {},
    this.encouragingMessage,
    this.isCheckpoint = false,
  });

  bool get isScale => type == QuestionType.scale;
  bool get isSingleChoice => type == QuestionType.single;
  bool get isMultipleChoice => type == QuestionType.multiple;
  bool get isImageChoice => type == QuestionType.imageChoice;
  bool get isPriorityRanking => type == QuestionType.priorityRanking;
}