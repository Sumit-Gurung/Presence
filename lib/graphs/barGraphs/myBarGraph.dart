import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence/model/myGroupReport.dart';

class MyBarGraph extends StatelessWidget {
  final List<Attendance>? presentAttendee;
  final int? totalMember;

  const MyBarGraph({super.key, this.presentAttendee, this.totalMember = 0});

  @override
  Widget build(BuildContext context) {
    if (presentAttendee == null || presentAttendee!.isEmpty) {
      return Center(child: Text("Not Enough Data"));
    }

    double maxValue = (presentAttendee ?? [])
        .map((e) => e.presentStudent ?? 0)
        .toList()
        .reduce((value, element) {
      if (element > value) value = element;
      return value;
    }).toDouble();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: presentAttendee!
            .map((attendance) => Container(
                  height: double.infinity,
                  width: 40,
                  // color: Colors.red,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Text(
                            DateFormat(DateFormat.ABBR_MONTH_DAY).format(
                              DateTime.parse(
                                attendance.date ?? DateTime.now().toString(),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Container(
                            color: Colors.white,
                            width: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        right: 0,
                        height: (attendance.presentStudent ?? 0).toDouble() /
                            maxValue *
                            (150 - 25),
                        left: 0,
                        child: Center(
                          child: Container(
                            height: double.infinity,
                            color: Colors.grey,
                            width: 20,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    attendance.presentStudent.toString(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
