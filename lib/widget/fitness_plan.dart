import 'package:flutter/material.dart';

class FitnessPlan {
  final DateTime date;
  final String bodyPart;
  final String workoutDescription;

  FitnessPlan({
    required this.date,
    required this.bodyPart,
    required this.workoutDescription,
  });
}
