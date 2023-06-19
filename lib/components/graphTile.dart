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
      height: 270,
      padding: EdgeInsets.all(20),
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
          SizedBox(
            height: 10,
          ),
          Text(
            'Present: $totalIndividual / $attendee',
            style:
                TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 140,
            child: child,
          ),
        ],
      ),
    );
  }
}
