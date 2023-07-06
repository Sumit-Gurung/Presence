import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/myGroup_tile.dart';
import 'package:presence/providers/group_Provider.dart';
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

// final List myGroupList = [
//   ['Programming In C', 47, 'jan 15,2022', 10],
//   ['Calculus-III', 30, 'march 30,2022', 10],
//   ['Software Project Management', 20, 'feb 15,2022', 11],
//   ['Network Programming', 47, 'jan 15,2022', 6],
//   // ['Dataaaa Mining', 37, 'june 15,2022', 10],
// ];
TextEditingController groupNameAddController = TextEditingController();

class _GroupsState extends State<Groups> {
  late Future<List<Group>> groups;
  @override
  void initState() {
    super.initState();

    groups = MyGroupRepository.getGroup();
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
                FutureBuilder(
                  future: groups,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error} found'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      final datafromSnapShot = snapshot.data;
                      final length = datafromSnapShot!.length;

                      return Expanded(
                          child: ListView.builder(
                        itemCount: length,
                        itemBuilder: (context, index) {
                          return MyGroupTile(
                              index: index,
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ManageAttendee(
                                        groupName: datafromSnapShot[index].name,
                                        groupId: datafromSnapShot[index].id,
                                        groupIndex: index,
                                      ),
                                    ));
                              },
                              groupName: '${datafromSnapShot[index].name}',
                              groupId: datafromSnapShot[index].id,
                              group: datafromSnapShot,
                              numberOfAttendee: 4,
                              numberOfRecords: 1,
                              date: DateFormat.yMMMd()
                                  .add_jm()
                                  .format(datafromSnapShot[index].created_at));
                        },
                      ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
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
