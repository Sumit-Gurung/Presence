import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:presence/graphs/barGraphs/barData.dart';
import 'package:presence/model/myGroupReport.dart';

class MyBarGraph extends StatelessWidget {
  final List<Attendance> presentAttendee;
  final int totalMember;

  const MyBarGraph(
      {super.key, required this.presentAttendee, required this.totalMember});

  @override
  Widget build(BuildContext context) {
    //
    return BarChart(
        swapAnimationCurve: Curves.easeInOut,
        swapAnimationDuration: Duration(milliseconds: 500),
        BarChartData(
            maxY: totalMember.toDouble(),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
                show: true,
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  reservedSize: 30,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                        axisSide: meta.axisSide, space: 1, child: Text('jan'));
                  },
                ))),
            minY: 0,
            barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.white, tooltipRoundedRadius: 12)),
            barGroups: presentAttendee
                .map((data) => BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                          toY: data.presentStudent!.toDouble(),
                          color: Colors.grey[700],
                          width: 15,
                          backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              color: Colors.grey[100],
                              toY: totalMember.toDouble()),
                          borderRadius: BorderRadius.all(Radius.zero))
                    ]))
                .toList()));
  }
}

// Widget getBottomTitle(double value, TitleMeta meta) {
//   const style =
//       TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11);
//   Widget text;

//   switch (value.toInt()) {
//     case 1:
//       text = const Text(
//         'Jan',
//         style: style,
//       );
//       break;
//     case 2:
//       text = const Text(
//         'Feb',
//         style: style,
//       );
//       break;
//     case 3:
//       text = const Text(
//         'Mar',
//         style: style,
//       );
//       break;
//     case 4:
//       text = const Text(
//         'Apr',
//         style: style,
//       );
//       break;
//     case 5:
//       text = const Text(
//         'May',
//         style: style,
//       );
//       break;
//     case 6:
//       text = const Text(
//         'Jun',
//         style: style,
//       );
//       break;
//     case 7:
//       text = const Text(
//         'jul',
//         style: style,
//       );
//       break;
//     default:
//       text = const Text(
//         '',
//         style: style,
//       );
//       break;
//   }
//   return SideTitleWidget(axisSide: meta.axisSide, child: text);
// }

// class MyBarGraph extends StatelessWidget {
//   final List MyWeeklyReport;

//   const MyBarGraph({super.key, required this.MyWeeklyReport});

//   @override
//   Widget build(BuildContext context) {
//     BarData myBarData = BarData(
//         MyWeeklyReport[0],
//         MyWeeklyReport[1],
//         MyWeeklyReport[2],
//         MyWeeklyReport[3],
//         MyWeeklyReport[4],
//         MyWeeklyReport[5],
//         MyWeeklyReport[6]);
//     myBarData.initBar();
//     return BarChart(BarChartData(
//         maxY: 100,
//         gridData: FlGridData(show: false),
//         borderData: FlBorderData(show: false),
//         titlesData: FlTitlesData(
//             show: true,
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                     reservedSize: 27,
//                     showTitles: true,
//                     getTitlesWidget: getBottomTitle))),
//         minY: 0,
//         barGroups: myBarData.barData
//             .map((data) => BarChartGroupData(x: data.x, barRods: [
//                   BarChartRodData(
//                       toY: data.y,
//                       color: Colors.grey[700],
//                       width: 15,
//                       backDrawRodData: BackgroundBarChartRodData(
//                           show: true, color: Colors.grey[100], toY: 100),
//                       borderRadius: BorderRadius.all(Radius.zero))
//                 ]))
//             .toList()));
//   }
// }

// Widget getBottomTitle(double value, TitleMeta meta) {
//   const style =
//       TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11);
//   Widget text;

//   switch (value.toInt()) {
//     case 1:
//       text = const Text(
//         'Jan',
//         style: style,
//       );
//       break;
//     case 2:
//       text = const Text(
//         'Feb',
//         style: style,
//       );
//       break;
//     case 3:
//       text = const Text(
//         'Mar',
//         style: style,
//       );
//       break;
//     case 4:
//       text = const Text(
//         'Apr',
//         style: style,
//       );
//       break;
//     case 5:
//       text = const Text(
//         'May',
//         style: style,
//       );
//       break;
//     case 6:
//       text = const Text(
//         'Jun',
//         style: style,
//       );
//       break;
//     case 7:
//       text = const Text(
//         'jul',
//         style: style,
//       );
//       break;
//     default:
//       text = const Text(
//         '',
//         style: style,
//       );
//       break;
//   }
//   return SideTitleWidget(axisSide: meta.axisSide, child: text);
// }
