// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
// import 'package:presence/components/constant.dart';

class HomePageGroupCard extends StatelessWidget {
  final String jobTitle;
  final String iconPath;
  final String horlyRate;

  const HomePageGroupCard(
      {super.key,
      required this.jobTitle,
      required this.iconPath,
      required this.horlyRate});

  // const HomePageGroupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400, spreadRadius: 5, blurRadius: 7),
            ],
            borderRadius: BorderRadius.circular(12)),
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 82,
                  width: 90,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(iconPath),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(5),
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      // border:
                      // Border.all(color: AppColors.authBasicColor, width: 2),
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                    child: Text(
                      'Join Now',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                jobTitle,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                '${horlyRate}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
