import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/myGroup_tile.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:presence/screens/enrolledGroupsScreen.dart';
import 'package:presence/screens/manageAttendee.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/group.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

TextEditingController groupNameAddController = TextEditingController();

class _GroupsState extends State<Groups> {
  List<Group> groups = [];
  int selectedTabIndex = 0;
  List<String> labels = ['My Groups', 'Enrolled Groups'];

  @override
  void initState() {
    super.initState();

    MyGroupRepository.getGroup().then((value) {
      setState(() {
        groups = value;
      });
    });
  }

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
                    Expanded(
                      child: Text(
                        'Groups',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                FlutterToggleTab(
                  labels: labels,
                  width: 87,
                  icons: const [
                    Icons.person,
                    Icons.group,
                  ],
                  selectedLabelIndex: (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  selectedTextStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  marginSelected:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  unSelectedTextStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  selectedBackgroundColors: [Colors.grey.shade800],
                  unSelectedBackgroundColors: [Colors.grey.shade200],
                  selectedIndex: selectedTabIndex,
                  isScroll: false,
                ),
                SizedBox(
                  height: 25,
                ),
                (selectedTabIndex == 0)
                    ? Expanded(
                        child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          return MyGroupTile(
                              index: index,
                              onGroupDelete: () {
                                setState(() {
                                  groups.removeAt(index);
                                });
                              },
                              onGroupUpdatedd: (value) {
                                setState(() {
                                  groups[index].name = value;
                                });
                              },
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ManageAttendee(
                                        groupName: groups[index].name,
                                        groupId: groups[index].id,
                                        groupIndex: index,
                                      ),
                                    ));
                              },
                              groupName: '${groups[index].name}',
                              groupId: groups[index].id,
                              // group: groups,
                              numberOfAttendee: groups[index]
                                  .numberOfAttendee, //number of attendee inside this group
                              numberOfRecords: 1,
                              date: DateFormat.yMMMd()
                                  .add_jm()
                                  .format(groups[index].created_at));
                        },
                      ))
                    : EnrolledGroupPage()
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
                              onPressed: () async {
                                Map groupName = {
                                  "name": groupNameAddController.text
                                };
                                var inst =
                                    await SharedPreferences.getInstance();
                                String authToken =
                                    inst.getString('accessToken')!;

                                var headers = {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $authToken',
                                };
                                var toSend = jsonEncode(groupName);

                                var response = await http.post(
                                    Uri.parse(Endpoints.forCreateGroup),
                                    headers: headers,
                                    body: toSend);
                                var showResponse = jsonDecode(response.body);

                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  Group justCreated = Group.fromMap(
                                      jsonDecode(response.body)['data']);
                                  groups.add(justCreated);
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Group Created Sucessfully")));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              " ${showResponse['name']}")));
                                }
                                // setState(() {
                                //   groupProviderVariable
                                //       .addToList(groupNameAddController.text);
                                // });

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
