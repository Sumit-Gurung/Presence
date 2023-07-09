import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/model/attendeeOfGroup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../components/custom_button.dart';
import '../utility/individual_attendance_tile.dart';

class TakeAttendance extends StatefulWidget {
  final String groupName;
  final int groupId;
  const TakeAttendance(
      {super.key, required this.groupName, required this.groupId});

  @override
  State<TakeAttendance> createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<AttendeeOfGroup> attendeeList = [];
  List listOfIdOfPresentAttendee = [];

  @override
  void initState() {
    super.initState();
    AttendeeOfGroupRepo.getAttendeeOfGroup(widget.groupId).then((value) {
      attendeeList = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopupMenuButton(
                  elevation: 10,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // selectedSortOption = 'nameAscending';
                          });
                        },
                        child: ListTile(
                          leading: Icon(CupertinoIcons.arrow_up_circle_fill),
                          title: Text("By Name"),
                        ),
                      )),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // selectedSortOption = 'nameDescending';
                          });
                        },
                        child: ListTile(
                          leading: Icon(CupertinoIcons.arrow_down_circle_fill),
                          title: Text("By Name"),
                        ),
                      )),
                    ];
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset('assets/images/preferences.png'),
                  ),
                ),
                Text(
                  'Take Attendance',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.groupName,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 0,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: attendeeList.length,
                itemBuilder: (context, index) {
                  return Individual_tile(
                    name: attendeeList[index].name,
                    profilePic: attendeeList[index].profilePic,
                    // attendeeId: attendeeList[index].id,
                    onSwitchChanged: (bool isSwitchOn) {
                      setState(() {
                        if (isSwitchOn) {
                          listOfIdOfPresentAttendee.add(attendeeList[index].id);
                        } else {
                          listOfIdOfPresentAttendee
                              .remove(attendeeList[index].id);
                        }
                      });
                    },
                  );
                }),
            SizedBox(
              height: 5,
            ),
            Center(
              child: CustomButton(
                  height: 65,
                  width: 210,
                  onTap: () async {
                    print(listOfIdOfPresentAttendee);
                    Map toSend = {
                      "present_user": listOfIdOfPresentAttendee,
                      "group": widget.groupId,
                      "status": true
                    };
                    var toSendAsString = jsonEncode(toSend);
                    final inst = await SharedPreferences.getInstance();
                    String authToken = inst.getString('accessToken')!;
                    var headers = {
                      'Content-Type': 'application/json',
                      "Authorization": "Bearer $authToken"
                    };
                    var response = await http.post(
                        Uri.parse(Endpoints.forTakingAttendance),
                        headers: headers,
                        body: toSendAsString);
                    var responseToShow = jsonDecode(response.body);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColors.authBasicColor,
                          duration: Duration(milliseconds: 1750),
                          content: Text(
                            '${responseToShow["message"]}',
                            style: TextStyle(color: Colors.white),
                          )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColors.authBasicColor,
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            '${responseToShow["error"]}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )));
                    }
                    print(response.body);
                    // print(attendeeList[0].id);
                  },
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
