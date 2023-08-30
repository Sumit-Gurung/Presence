// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/model/getnotificationModel.dart';
import 'package:presence/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  // final List NotificationList = [
  //   ["New Message", 'You have a new message from John Doe.', '10:30 AM'],
  //   [
  //     'New Message',
  //     'Don\'t forget to attend the meeting at 2:00 PM.',
  //     '11:45 AM'
  //   ],
  //   ['Event Invitation', 'You are invited to a party on Saturday.', '1:15 PM']
  // ];

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
      appBar: AppBar(
        title: Text('Notifications'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[200],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: notificationList.length,
                itemBuilder: (context, index) {
                  return NotificationItem(
                    senderid: notificationList[index].sender!,
                    senderName: 'sumit',
                    groupId: notificationList[index].group!,
                    groupName: 'Hamro GROUP',
                    date: DateFormat('MMM d, y').format(
                      notificationList[index].sendAt!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
        padding: EdgeInsets.all(7),
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
                  Text(
                    '$senderName has requested\n to join $groupName',
                    style: GoogleFonts.acme(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                  Text(
                    'on: $date',
                    style: GoogleFonts.acme(
                        textStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 12)),
                  )
                ]),
            Row(
              children: [
                Container(
                    height: 30,
                    width: 83,
                    child: ElevatedButton(
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
                    width: 83,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade400)),
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
