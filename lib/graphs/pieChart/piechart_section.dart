import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:presence/graphs/pieChart/pichart_data.dart';

List<PieChartSectionData> getSection(int touchedIndex) => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 16 : 11;
      final double radius = isTouched ? 37 : 29;

      final value = PieChartSectionData(
          color: data.color,
          value: data.percentage,
          radius: radius,
          title: '${data.percentage}%',
          titleStyle: TextStyle(
            color: data.isAbsent ? Colors.black : Colors.white,
            fontSize: fontSize,
          ));
      return MapEntry(index, value);
    })
    .values
    .toList();
