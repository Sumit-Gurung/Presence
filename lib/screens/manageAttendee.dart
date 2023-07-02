import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:presence/providers/Individual_attendee_provider.dart';
import 'package:presence/providers/group_Provider.dart';
// import 'package:presence/utility/individual_attendance_tile.dart';
import 'package:provider/provider.dart';

import '../utility/manageAttendeeTile.dart';

class ManageAttendee extends StatefulWidget {
  final int groupIndex;

  const ManageAttendee({super.key, required this.groupIndex});
  // const ManageAttendee({Key? key}) : super(key: key);

  @override
  State<ManageAttendee> createState() => _ManageAttendeeState();
}

class _ManageAttendeeState extends State<ManageAttendee> {
  TextEditingController nameAddController = TextEditingController();
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AttendeeProvider, GroupProvider>(
      builder: (context, attendeeVariable, groupProviderVariable, child) {
        return Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: SpeedDial(
              // buttonSize: Size(25, 25),
              icon: Icons.menu,
              activeIcon: Icons.close,
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              activeBackgroundColor: Colors.blueGrey,
              activeForegroundColor: Colors.white,
              curve: Curves.bounceIn,
              visible: true,
              childMargin: EdgeInsets.all(15),
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  label: 'Add Attendee',
                  labelStyle: TextStyle(fontSize: 16),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add Attendee'),
                          content: TextFormField(
                              controller: nameAddController,
                              decoration: InputDecoration(
                                  hintText: 'Enter Attendee Name')),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('cancel')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    // attendeeVariable
                                    //     .addToList(nameAddController.text);
                                    groupProviderVariable.addAttendeeToGroup(
                                        nameAddController.text,
                                        widget.groupIndex);
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text('ok')),
                          ],
                        );
                      },
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.edit),
                  label: 'Edit',
                  labelStyle: TextStyle(fontSize: 16),
                  onTap: () {},
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset('assets/images/preferences.png'),
                        ),
                        Text(
                          'Manage Attendee',
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
                          groupProviderVariable.myGroups[widget.groupIndex]
                              ['groupName'],
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

                    Expanded(
                      child: ListView.builder(
                          // itemCount: attendeeVariable.attendeeName.length,
                          itemCount: groupProviderVariable
                              .myGroups[widget.groupIndex]["attendeeList"]
                              .length,
                          // attendeeVariable.attendeeName.length,
                          itemBuilder: (context, index) {
                            return ManageAttendeeTile(
                              attendee: groupProviderVariable
                                      .myGroups[widget.groupIndex]
                                  ["attendeeList"][index],
                              attendeeIndex: index,
                              groupIndex: widget.groupIndex,
                            );
                          }),
                    )
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: ListView.builder(itemBuilder: (context, index) {
                    //     return Individual_tile();
                    //   }),
                    // )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
