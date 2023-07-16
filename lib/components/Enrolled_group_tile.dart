import 'package:flutter/material.dart';

import 'constant.dart';

class EnrolledGroupTile extends StatelessWidget {
  final String groupName;
  final String createrName;
  final String date;
  final int totalMembers;
  final VoidCallback ontap;

  const EnrolledGroupTile(
      {super.key,
      required this.groupName,
      required this.createrName,
      required this.date,
      required this.ontap,
      required this.totalMembers});
  // const EnrolledGroupTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 20),
        width: double.maxFinite,
        // height: double.maxFinite,

        decoration: BoxDecoration(
            color: AppColors.tilebackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: -2,
                  color: Colors.grey.shade500,
                  offset: Offset(1, 6)),
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              groupName,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By : $createrName',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'since $date',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Text(
                  '$totalMembers Members',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
