import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:presence/graphs/pieChart/pichart_data.dart';

List<PieChartSectionData> getSection(int touchedIndex) {
  return PieData.data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        // final isTouched = index == touchedIndex;
        // final double fontSize = isTouched ? 13 : 10;
        // final double radius = isTouched ? 48 : 34;

        final value = PieChartSectionData(
          color: data.color,
          value: data.percentage,
          radius: 34,
          title: '${double.parse(data.percentage.toStringAsFixed(1))}%',
          titleStyle: TextStyle(
            color: data.isAbsent ? Colors.black : Colors.white,
            fontSize: 10,
          ),
        );
        return MapEntry(index, value);
      })
      .values
      .toList();
}
