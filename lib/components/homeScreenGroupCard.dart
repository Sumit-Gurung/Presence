// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageGroupCard extends StatelessWidget {
  final String groupName;
  final int groupId;

  final int numberOfMembers;
  final String date;
  final String creatorName;

  const HomePageGroupCard(
      {super.key,
      required this.groupName,
      required this.groupId,
      required this.numberOfMembers,
      required this.creatorName,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400, spreadRadius: 5, blurRadius: 7),
            ],
            borderRadius: BorderRadius.circular(12)),
        width: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Center(
                child: Text(
                  groupName,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                'Created By: ${creatorName}',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                'Created on: ${date}',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                'No. of Members: ${numberOfMembers}',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                Map toSendNotification = {
                  "message": "add me to ur group",
                  "group": groupId
                };
                var inst = await SharedPreferences.getInstance();
                String accessToken = inst.getString('accessToken')!;

                String toSendAsStringNotification =
                    jsonEncode(toSendNotification);
                var response = await http.post(
                    Uri.parse(Endpoints.forSendNotification),
                    headers: {
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $accessToken'
                    },
                    body: toSendAsStringNotification);

                var notificationResponseInJson =
                    jsonDecode(response.body)['message'];

                if (response.statusCode == 200 || response.statusCode == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$notificationResponseInJson')));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Failed')));
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 15, left: 15.0),
                // padding: EdgeInsets.all(5),
                height: 38,
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    // border:
                    // Border.all(color: AppColors.authBasicColor, width: 2),
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(
                    'Request To Join',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   height: 82,
//                   width: 90,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(12)),
//                   child: Text(
//                     'ID : 1',
//                     style: TextStyle(fontSize: 26),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(right: 8),
//                   padding: EdgeInsets.all(5),
//                   height: 45,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[600],
//                       // border:
//                       // Border.all(color: AppColors.authBasicColor, width: 2),
//                       borderRadius: BorderRadius.circular(7)),
//                   child: Center(
//                     child: Text(
//                       'Join Now',
//                       style: TextStyle(fontSize: 14, color: Colors.white),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0),
//               child: Text(
//                 groupName,
//                 style: TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 0),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0),
//               child: Text(
//                 '${numberOfMembers}',
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey.shade700),
//               ),
//             ),
//           ],
//         ),