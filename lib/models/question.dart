import 'package:flutter/material.dart';
import 'category.dart';

enum QuestionType {
  singleChoice,
  multipleChoice,
  scale,
  imageChoice,
  priorityRanking;

  bool get isSingleChoice => this == QuestionType.singleChoice;
  bool get isMultipleChoice => this == QuestionType.multipleChoice;
  bool get isScale => this == QuestionType.scale;
  bool get isImageChoice => this == QuestionType.imageChoice;
  bool get isPriorityRanking => this == QuestionType.priorityRanking;
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<Category> categories;
  final Map<String, double> categoryWeights;
  final List<String>? options;
  final List<String>? imageOptions;
  final Map<int, String>? scaleLabels;
  final String? encouragingMessage;
  final bool isCheckpoint;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    required this.categories,
    required this.categoryWeights,
    this.options,
    this.imageOptions,
    this.scaleLabels,
    this.encouragingMessage,
    this.isCheckpoint = false,
  });

  bool get requiresImages => type == QuestionType.imageChoice;
  bool get requiresOptions => type == QuestionType.singleChoice || 
                            type == QuestionType.multipleChoice || 
                            type == QuestionType.priorityRanking;
  bool get requiresScaleLabels => type == QuestionType.scale;
}