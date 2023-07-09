import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presence/model/attendeeOfGroup.dart';

import '../components/custom_button.dart';
import '../utility/individual_attendance_tile.dart';

class TakeAttendance extends StatefulWidget {
  final String groupName;
  const TakeAttendance({super.key, required this.groupName});

  @override
  State<TakeAttendance> createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<AttendeeOfGroup> attendeeList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      AttendeeOfGroupRepo.getAttendeeOfGroup().then((value) {
        attendeeList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.groupName,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: attendeeList.length,
                itemBuilder: (context, index) {
                  return Individual_tile(
                    name: attendeeList[index].name,
                    profilePic: attendeeList[index].profilePic,
                  );
                }),
            Center(
              child: CustomButton(
                  height: 65,
                  width: 210,
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
