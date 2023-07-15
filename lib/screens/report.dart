import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:presence/components/graphTile.dart';
import 'package:presence/graphs/barGraphs/myBarGraph.dart';
import 'package:presence/graphs/pieChart/piechart_section.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

final List weeklyReport = [50.0, 12.4, 19.3, 30.2, 25.66, 26.3, 36.5];
final List<String> labels = ['Group Report', 'My Report'];
int selectedTabIndex = 0;
int touchedIndex = -1;

class _ReportState extends State<Report> {
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
                ? MyGraphTile(
                    attendee: 33,
                    groupName: 'Programming in C',
                    totalIndividual: 47,
                    child: MyBarGraph(
                      MyWeeklyReport: weeklyReport,
                    ),
                  )
                : MyGraphTile(
                    attendee: 29,
                    groupName: 'Data Mining ',
                    totalIndividual: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AspectRatio(
                            aspectRatio: 1.0,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event,
                                      PieTouchResponse? pieTouchResponse) {
                                    if (event is FlLongPressEnd ||
                                        event is FlPanEndEvent ||
                                        pieTouchResponse?.touchedSection ==
                                            null) {
                                      setState(() {
                                        touchedIndex = -1;
                                      });
                                    } else {
                                      setState(() {
                                        touchedIndex = pieTouchResponse!
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      });
                                    }
                                  },
                                ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  style: TextStyle(color: Colors.grey[700]),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  style: TextStyle(color: Colors.grey[700]),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ))
          ],
        ),
      ),
    ));
  }
}
