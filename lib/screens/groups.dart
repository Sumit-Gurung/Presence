import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/myGroup_tile.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:presence/screens/manageAttendee.dart';
import 'package:provider/provider.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

// final List myGroupList = [
//   ['Programming In C', 47, 'jan 15,2022', 10],
//   ['Calculus-III', 30, 'march 30,2022', 10],
//   ['Software Project Management', 20, 'feb 15,2022', 11],
//   ['Network Programming', 47, 'jan 15,2022', 6],
//   // ['Dataaaa Mining', 37, 'june 15,2022', 10],
// ];
TextEditingController groupNameAddController = TextEditingController();

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProviderVariable, child) {
      return SafeArea(
          child: Stack(children: [
        Container(
          color: AppColors.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    // IconButton(
                    //     constraints: const BoxConstraints(),
                    //     padding: EdgeInsets.zero,
                    //     onPressed: () => Navigator.pop(context),
                    //     icon: const Icon(Icons.arrow_back,
                    //         color: Colors.black, size: 25)),
                    Expanded(
                      child: Text(
                        'My Groups',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return MyGroupTile(
                        index: index,
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageAttendee(
                                  groupIndex: index,
                                ),
                              ));
                        },
                        groupName: groupProviderVariable.myGroups[index]
                            ["groupName"],
                        numberOfAttendee: groupProviderVariable.myGroups[index]
                            ['numberOfAttendee'],
                        numberOfRecords: groupProviderVariable.myGroups[index]
                            ['numberOfRecord'],
                        date: groupProviderVariable.myGroups[index]['date']);
                  },
                  itemCount: groupProviderVariable.myGroups.length,
                ))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 24,
          child: SpeedDial(
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
                label: 'Create Group',
                labelStyle: TextStyle(fontSize: 16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Create Group'),
                        content: TextFormField(
                            controller: groupNameAddController,
                            decoration:
                                InputDecoration(hintText: 'Enter Group Name')),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('cancel')),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  groupProviderVariable
                                      .addToList(groupNameAddController.text);
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
                label: 'Edit Group',
                labelStyle: TextStyle(fontSize: 16),
                onTap: () {},
              ),
            ],
          ),
        )
      ]));
    });
  }
}
