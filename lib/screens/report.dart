import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:presence/components/graphTile.dart';
import 'package:presence/graphs/barGraphs/myBarGraph.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

final List weeklyReport = [50.0, 12.4, 19.3, 30.2, 25.66, 26.3, 36.5];
final List<String> labels = ['Group Report', 'My Report'];
int selectedTabIndex = 0;

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
                    'My Reports',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            FlutterToggleTab(
              labels: labels,
              width: 87,
              icons: [
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
                    attendee: 33,
                    groupName: 'Personal ',
                    totalIndividual: 20,
                    child: MyBarGraph(
                      MyWeeklyReport: weeklyReport,
                    ),
                  )
          ],
        ),
      ),
    ));
  }
}
