import 'package:flutter/material.dart';
import 'package:presence/components/graphTile.dart';
import 'package:presence/graphs/barGraphs/myBarGraph.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

final List weeklyReport = [50.0, 12.4, 19.3, 30.2, 25.66, 26.3, 36.5];

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
            SizedBox(
              height: 25,
            ),
            MyGraphTile(
              attendee: 33,
              groupName: 'Programming in C',
              totalIndividual: 47,
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
