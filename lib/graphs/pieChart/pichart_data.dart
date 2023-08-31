import 'package:flutter/material.dart';

import '../../model/enrolled_Group_Report.dart';

List<EnrolledGroupReport> enrolledGrpReport = [];

class PieData {
  static List<Data> data = [];

  static Future<void> fetchData() async {
    try {
      final List<EnrolledGroupReport> enrolledGrpReports =
          await EnrolledGroupReportRepo.getEnrolledGroupReport();

      if (enrolledGrpReports.isNotEmpty) {
        List<Data> newData = [];
        var totalDays;

        for (var report in enrolledGrpReports) {
          if (report.totalDays == 0) {
            totalDays = 1;
          } else {
            totalDays = report.totalDays;
          }
          var pp = (report.presentDays / totalDays) * 100;
          double presentPercentage = pp.toDouble();
          // double totalPercentage = report.totalDays.toDouble();
          double absentPercentage = 100 - presentPercentage;

          newData.add(
            Data(
              name: 'Present',
              percentage: presentPercentage,
              color: Colors.grey.shade800,
              isAbsent: false,
            ),
          );

          newData.add(
            Data(
              name: 'Absent',
              percentage: absentPercentage,
              color: Colors.grey.shade300,
              isAbsent: true,
            ),
          );
        }

        data = newData;
      }
    } catch (e) {
      print('Error: $e');
    }
  }
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
