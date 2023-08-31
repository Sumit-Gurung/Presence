import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

class MyGraphTile extends StatelessWidget {
  final Widget child;
  final String groupName;
  final int totalIndividual;
  final int? attendee;
  final bool isMyreport;

  const MyGraphTile(
      {super.key,
      required this.groupName,
      required this.totalIndividual,
      this.attendee,
      required this.isMyreport,
      required this.child});
  // const MyGrpahTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: -2,
                color: Colors.grey.shade500,
                offset: Offset(1, 6)),
          ],
          color: AppColors.tilebackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          isMyreport
              ? Text(
                  'Present: $attendee / $totalIndividual  ',
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w600),
                )
              : Text(
                  'Total Attendee: $totalIndividual  ',
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w600),
                ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 150,
            child: child,
          ),
        ],
      ),
    );
  }
}
