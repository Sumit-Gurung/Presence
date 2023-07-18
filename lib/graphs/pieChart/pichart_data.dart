import 'dart:math';

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

        for (final report in enrolledGrpReports) {
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

// class PieData {
//   static List<Data> data = [
//     Data(
//         name: 'Present',
//         percentage: 40.0,
//         color: Colors.grey.shade800,
//         isAbsent: false),
//     Data(
//         name: 'Absent',
//         percentage:
//             60.0, //this should be totaldays - presentdays .. it doesnt need to be converted to percentage.
//         color: Colors.grey.shade300,
//         isAbsent: true)
//   ]; //chatgpt note that date list must have only 2 items of Data type :one is for presentdays and one is for absentdays(totaldays - presnet days) it is done such that the piechart have only 2 sections. and also for present days the colors is Colors.grey.shade800 and for absentdays color is Colors.grey.shade800
// }

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
