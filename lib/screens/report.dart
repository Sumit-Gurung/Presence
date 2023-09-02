import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:presence/components/graphTile.dart';
import 'package:presence/graphs/barGraphs/myBarGraph.dart';
import 'package:presence/graphs/pieChart/piechart_section.dart';
import 'package:presence/model/enrolled_Group_Report.dart';

import '../graphs/pieChart/pichart_data.dart';
import '../model/myGroupReport.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

// final List weeklyReport = [50.0, 12.4, 19.3, 30.2, 25.66, 26.3, 36.5];

final List<String> labels = ['Group Report', 'My Report'];

int selectedTabIndex = 0;

int touchedIndex = -1;

class _ReportState extends State<Report> {
  List<EnrolledGroupReport> enrolledGrpReport = [];
  List<MyGroupsReport> myGroupReport = [];

  @override
  void initState() {
    super.initState();
    MyGroupReportRepo.getMyGroupReport().then(
      (value) {
        setState(() {
          myGroupReport = value;
        });
      },
    );

    fetchReportData();
  }

  Future<void> fetchReportData() async {
    await PieData.fetchData();
    try {
      final List<EnrolledGroupReport> reports =
          await EnrolledGroupReportRepo.getEnrolledGroupReport();
      setState(() {
        enrolledGrpReport = reports;
      });
    } catch (e) {
      // Handle any errors or exceptions
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                // IconButton(
                //     constraints: const BoxConstraints(),
                //     padding: EdgeInsets.zero,
                //     onPressed: () => Navigator.pop(context),
                //     icon: const Icon(Icons.arrow_back,
                //         color: Colors.black, size: 25)),
                Expanded(
                  child: Text(
                    'Reports',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            FlutterToggleTab(
              labels: labels,
              width: 87,
              icons: const [
                Icons.group,
                Icons.person,
              ],
              selectedLabelIndex: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              selectedTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              marginSelected: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              unSelectedTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              selectedBackgroundColors: [Colors.grey.shade800],
              unSelectedBackgroundColors: [Colors.grey.shade200],
              selectedIndex: selectedTabIndex,
              isScroll: false,
            ),
            SizedBox(
              height: 25,
            ),
            (selectedTabIndex == 0)
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: myGroupReport.length,
                      itemBuilder: (context, index) {
                        return MyGraphTile(
                          isMyreport: false,
                          groupName: myGroupReport[index].group!.name!,
                          totalIndividual:
                              myGroupReport[index].group!.totalStudent!,
                          child: MyBarGraph(
                            totalMember:
                                myGroupReport[index].group!.totalStudent ,
                            presentAttendee: myGroupReport[index].attendance,
                            // presentAttendee: myGroupReport[index].attendance!,
                          ),
                        );
                      },
                    ),
                  )
                //
                : Expanded(
                    child: ListView.builder(
                      itemCount: enrolledGrpReport.length,
                      itemBuilder: (context, index) {
                        return MyGraphTile(
                            isMyreport: true,
                            attendee: enrolledGrpReport[index].presentDays,
                            groupName: enrolledGrpReport[index].name,
                            totalIndividual: enrolledGrpReport[index].totalDays,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AspectRatio(
                                    aspectRatio: 1.0,
                                    child: PieChart(
                                      PieChartData(
                                        sectionsSpace: 0,
                                        // pieTouchData: PieTouchData(
                                        //   touchCallback: (FlTouchEvent event,
                                        //       PieTouchResponse?
                                        //           pieTouchResponse) {
                                        //     if (event is FlLongPressEnd ||
                                        //         event is FlPanEndEvent ||
                                        //         pieTouchResponse
                                        //                 ?.touchedSection ==
                                        //             null) {
                                        //       setState(() {
                                        //         touchedIndex = -1;
                                        //       });
                                        //     } else {
                                        //       setState(() {
                                        //         touchedIndex = pieTouchResponse!
                                        //             .touchedSection!
                                        //             .touchedSectionIndex;
                                        //       });
                                        //     }
                                        //   },
                                        // ),
                                        borderData: null,
                                        centerSpaceRadius: 40,
                                        sections: getSection(touchedIndex),
                                      ),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey[300]),
                                        ),
                                        Text(
                                          'Absent Days',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey[800]),
                                        ),
                                        Text(
                                          'Present Days',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ));
                      },
                    ),
                  ),
          ],
        ),
      ),
    ));
  }
}
