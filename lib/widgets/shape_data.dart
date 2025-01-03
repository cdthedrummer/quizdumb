import 'package:flutter/material.dart';

enum ShapeType {
  circle,
  triangle,
  star,
}

class ShapeData {
  final AnimationController controller;
  final Color color;
  final double size;
  Offset position;
  final ShapeType shape;

  ShapeData({
    required this.controller,
    required this.color,
    required this.size,
    required this.position,
    required this.shape,
  });
}