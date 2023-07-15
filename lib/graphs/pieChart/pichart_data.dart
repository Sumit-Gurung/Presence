import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(
        name: 'Present',
        percentage: 40.0,
        color: Colors.grey.shade800,
        isAbsent: false),
    Data(
        name: 'Absent',
        percentage: 60.0,
        color: Colors.grey.shade300,
        isAbsent: true)
  ];
}

class Data {
  final String name;
  final double percentage;
  final Color color;
  final bool isAbsent;
  Data(
      {required this.name,
      required this.percentage,
      required this.color,
      required this.isAbsent});
}
