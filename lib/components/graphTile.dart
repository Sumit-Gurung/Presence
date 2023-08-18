import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

class MyGraphTile extends StatelessWidget {
  final Widget child;
  final String groupName;
  final int totalIndividual;
  final int attendee;

  const MyGraphTile(
      {super.key,
      required this.groupName,
      required this.totalIndividual,
      required this.attendee,
      required this.child});
  // const MyGrpahTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
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
          Text(
            'Present: $attendee / $totalIndividual  ',
            style:
                TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
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
