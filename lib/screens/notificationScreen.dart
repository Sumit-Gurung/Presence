// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/myAppBar.dart';
import 'package:presence/model/getnotificationModel.dart';

// import 'package:presence/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<GetNotification> notificationList = [];
  List<int> selectedUserIds = [];
  @override
  void initState() {
    super.initState();
    GetNotificationRepo.getNotification().then(
      (value) {
        setState(() {
          notificationList = value;
        });
      },
    );
  }

  // String getCreatorName(int id) {
  //   try {
  //     final user = filteredUsers.firstWhere(
  //       (user) => user.id == id,
  //       orElse: () => UserDetails(
  //           id: 99,
  //           email: 'dsa@gma.com',
  //           name: 'random',
  //           phoneNumber: '9874563210',
  //           profilePic: 'saddas'),
  //     );

  //     return user.name;
  //   } catch (e, s) {
  //     // Handle any errors or exceptions that occur during the retrieval
  //     print('Error: $e');
  //     print(s);
  //     return 'Error retrieving user';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      //
      body: Column(
        children: [
          MyAppBar(title: 'Notification'),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  for (var notificationn in notificationList)
                    NotificationItem(
                      senderid: notificationn.sender!,
                      senderName: notificationn.sendername!,
                      groupId: notificationn.group!,
                      groupName: notificationn.groupname!,
                      date: DateFormat('MMM d, y').format(
                        notificationn.sendAt!,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String senderName;
  final int senderid;
  final String groupName;
  final int groupId;
  final String date;

  const NotificationItem(
      {super.key,
      required this.senderid,
      required this.senderName,
      required this.groupId,
      required this.groupName,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 16),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.tilebackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      children: [
                        TextSpan(
                          text: '$senderName',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        TextSpan(text: ' has requested\n to join '),
                        TextSpan(
                          text: '$groupName',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'on: $date',
                    style: GoogleFonts.acme(
                        textStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 11)),
                  )
                ]),
            Row(
              children: [
                Container(
                    height: 30,
                    width: 65,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 0), // Adjust padding values
                        ),
                        onPressed: () async {
                          Map tosend = {
                            "action": "add",
                            "user": [senderid],
                            "group": groupId
                          };
                          var inst = await SharedPreferences.getInstance();
                          String accessToken = inst.getString('accessToken')!;

                          var headers = {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $accessToken',
                          };

                          var response = await http.post(
                              Uri.parse(
                                  Endpoints.forAddingOrRemovingAttendeeToGroup),
                              headers: headers,
                              body: jsonEncode(tosend));
                          var responsetoShow =
                              jsonDecode(response.body)['message'];
                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: AppColors.authBasicColor,
                                duration: Duration(milliseconds: 1400),
                                content: Text('$responsetoShow')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: AppColors.authBasicColor,
                                duration: Duration(milliseconds: 1400),
                                content: Text('$responsetoShow ')));
                            print(
                                "Unsucessfull with statuscode: ${response.statusCode} ");
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: 12),
                        ))),
                SizedBox(
                  width: 5,
                ),
                Container(
                    height: 30,
                    width: 65,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          padding: EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 0), // Adjust padding values
                        ),
                        onPressed: () {},
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ))),
              ],
            )
          ],
        ));
  }
}
//

// ListTile(
// leading: Column(
//   mainAxisAlignment: MainAxisAlignment.start,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     // CircleAvatar(
//     //   backgroundColor: Colors.grey[800],
//     //   child: Icon(
//     //     Icons.notifications,
//     //     color: Colors.white,
//     //   ),
//     // ),
//   ],
// ),
//   title: Text(
//     title,
//     style: TextStyle(
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//   subtitle: Text(
//     subtitle,
//     style: TextStyle(height: 1.3),
//   ),
//   // trailing:
// ),
