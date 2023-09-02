import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence/model/myGroupReport.dart';

class MyBarGraph extends StatelessWidget {
  final List<Attendance> presentAttendee;
  final int totalMember;

  const MyBarGraph(
      {super.key, required this.presentAttendee, required this.totalMember});

  @override
  Widget build(BuildContext context) {
    int indexOfBottomTitle = 0;
    // double maxValue = presentAttendee
    //     .map((e) => e.presentStudent ?? 0)
    //     .toList()
    //     .reduce((value, element) {
    //   if (element > value) value = element;
    //   return value;
    // }).toDouble();
    return BarChart(
        swapAnimationCurve: Curves.easeInOut,
        swapAnimationDuration: Duration(milliseconds: 500),
        BarChartData(
            // maxY: maxValue,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 30,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    indexOfBottomTitle =
                        indexOfBottomTitle++ % presentAttendee.length;
                    var date = DateTime.parse(
                        presentAttendee[indexOfBottomTitle].date ??
                            DateTime.now().toString());
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 1,
                      child: Text(
                        DateFormat(DateFormat.ABBR_MONTH_DAY).format(date),
                      ),
                    );
                  },
                ),
              ),
            ),
            minY: 0,
            barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.white, tooltipRoundedRadius: 12)),
            barGroups: presentAttendee
                .map((data) => BarChartGroupData(x: 0, barsSpace: 10, barRods: [
                      BarChartRodData(
                          toY: data.presentStudent!.toDouble(),
                          // toY: 5,
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
