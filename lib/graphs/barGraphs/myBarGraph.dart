import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:presence/graphs/barGraphs/barData.dart';

class MyBarGraph extends StatelessWidget {
  final List MyWeeklyReport;

  const MyBarGraph({super.key, required this.MyWeeklyReport});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        MyWeeklyReport[0],
        MyWeeklyReport[1],
        MyWeeklyReport[2],
        MyWeeklyReport[3],
        MyWeeklyReport[4],
        MyWeeklyReport[5],
        MyWeeklyReport[6]);
    myBarData.initBar();
    return BarChart(BarChartData(
        maxY: 100,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTitle))),
        minY: 0,
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.grey[700],
                      width: 15,
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, color: Colors.grey[100], toY: 100),
                      borderRadius: BorderRadius.all(Radius.zero))
                ]))
            .toList()));
  }
}

Widget getBottomTitle(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;

  switch (value.toInt()) {
    case 1:
      text = const Text(
        'S',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Th',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 7:
      text = const Text(
        'Sat',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
