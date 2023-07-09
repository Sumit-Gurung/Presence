import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/model/attendeeOfGroup.dart';
import 'package:presence/providers/Individual_attendee_provider.dart';
import 'package:presence/providers/group_Provider.dart';
// import 'package:presence/screens/homescreen.dart';
import 'package:presence/screens/takeAttendance.dart';
// import 'package:presence/screens/searchModule.dart';
// import 'package:presence/utility/individual_attendance_tile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/manageAttendeeTile.dart';

class ManageAttendee extends StatefulWidget {
  final int groupIndex;
  final String groupName;
  final int groupId;

  const ManageAttendee(
      {super.key,
      required this.groupIndex,
      required this.groupName,
      required this.groupId});
  // const ManageAttendee({Key? key}) : super(key: key);

  @override
  State<ManageAttendee> createState() => _ManageAttendeeState();
}

class _ManageAttendeeState extends State<ManageAttendee> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  dynamic selectedUser;

  TextEditingController nameAddController = TextEditingController();
  bool isSwitch = false;
  String selectedSortOption = '';
  List<AttendeeOfGroup> attendeeList = [];
  bool isSelected = false;
  //List<dynamic>

  @override
  void initState() {
    super.initState();
    // setGroupId();

    AttendeeOfGroupRepo.getAttendeeOfGroup(widget.groupId).then(
      (value) {
        setState(() {
          attendeeList = value;
        });
      },
    );

    fetchAllUsers();
    // setState(() {
    //   final grpProviderVariable =
    //       Provider.of<GroupProvider>(context, listen: false);
    //   attendeeList =
    //       grpProviderVariable.myGroups[widget.groupIndex]["attendeeList"];
    // });
  }

  // void setGroupId() async {
  //   var inst = await SharedPreferences.getInstance();
  //   await inst.setInt("groupId", widget.groupId);
  // }

//for searching fetchAllusers(),filterUSers(),selectedUser()
  Future<void> fetchAllUsers() async {
    final response = await http.get(Uri.parse(Endpoints.forAllUsers));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['users'];
        filteredUsers = users;
      });
    } else {
      // Handle error if necessary
      print('Failed to load data');
    }
  }

  void filterUsers(String query) {
    setState(() {
      selectedUser = null;
      filteredUsers = query.isEmpty
          ? []
          : users
              .where((user) =>
                  user['name'].toLowerCase().contains(query.toLowerCase()) ||
                  user['email'].toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  void selectUser(dynamic user) {
    setState(() {
      isSelected = true;
      selectedUser = user;
      searchController.text = user['name'];
    });
  }

//for sorting
  // List<dynamic> sortAttendees() {
  //   switch (selectedSortOption) {
  //     case 'nameAscending':
  //       return List<Map<String, dynamic>>.from(attendeeList)
  //         ..sort((a, b) => a["name"].compareTo(b["name"]));
  //     case 'nameDescending':
  //       return List<Map<String, dynamic>>.from(attendeeList)
  //         ..sort((a, b) => b["name"].compareTo(a["name"]));
  //     case 'presentDaysAscending':
  //       return List<Map<String, dynamic>>.from(attendeeList)
  //         ..sort((a, b) => a["presentDays"].compareTo(b["presentDays"]));
  //     case 'presentDaysDescending':
  //       return List<Map<String, dynamic>>.from(attendeeList)
  //         ..sort((a, b) => b["presentDays"].compareTo(a["presentDays"]));
  //     default:
  //       return attendeeList;
  //   }
  // }

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
                        return StatefulBuilder(
                          builder: (context, setState101) {
                            return AlertDialog(
                              backgroundColor: AppColors.backgroundColor,
                              title: Text('Add Attendee'),
                              content: Container(
                                height: 400,
                                width: double.maxFinite,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: (value) {
                                          setState101(
                                            () {
                                              filterUsers(value);
                                            },
                                          );
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Search',
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                        // filterUsers,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: filteredUsers.length,
                                        itemBuilder: (context, index) {
                                          // setState101(
                                          //   () {},
                                          // );
                                          final user = filteredUsers[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .tilebackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: isSelected
                                                      ? Border.all(
                                                          color: Colors.green)
                                                      : null,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 7,
                                                        spreadRadius: 1,
                                                        color: Colors
                                                            .grey.shade500,
                                                        offset: Offset(2, 6)),
                                                  ]),
                                              child: ListTile(
                                                  onTap: () => selectUser(user),
                                                  leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        "${Endpoints.url}${user['profilePic']}" ??
                                                            'https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
                                                    // ('${user['profilePic']}' != null)
                                                    //     ? NetworkImage(
                                                    //             "${Endpoints.url} ${user['profilePic']}")
                                                    //         as ImageProvider
                                                    //     : AssetImage('assets/images/avatar.jpg'),
                                                  ),

                                                  // (user.user != null &&
                                                  //             user.user!.imagePath != null)
                                                  //         ? NetworkImage(user.user!.imagePath!)
                                                  //             as ImageProvider
                                                  //         : AssetImage('assets/images/avatar.jpg'),
                                                  title: Text(user['name']),
                                                  subtitle: Text(
                                                    user['email'],
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                  ),
                                                  trailing: Icon(CupertinoIcons
                                                      .person_add)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('cancel')),
                                TextButton(
                                    onPressed: () async {
                                      Map tosend = {
                                        "action": "add",
                                        "user": selectedUser['id'],
                                        "group": widget.groupId
                                      };
                                      var inst =
                                          await SharedPreferences.getInstance();
                                      String accessToken =
                                          inst.getString('accessToken')!;

                                      var headers = {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer $accessToken',
                                      };

                                      var response = await http.post(
                                          Uri.parse(Endpoints
                                              .forAddingOrRemovingAttendeeToGroup),
                                          headers: headers,
                                          body: jsonEncode(tosend));
                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        AttendeeOfGroup justCreated =
                                            AttendeeOfGroup.fromMap(
                                                selectedUser);
                                        attendeeList.add(justCreated);
                                        setState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Attendee has been added!')));
                                      } else {
                                        print(
                                            "Unsucessfull with statuscode: ${response.statusCode} ");
                                      }

                                      print(response.body);

                                      groupProviderVariable.addAttendeeToGroup(
                                          selectedUser['name'],
                                          widget.groupIndex);

                                      Navigator.pop(context);
                                    },
                                    child: Text('ok')),
                              ],
                            );
                          },
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
                SpeedDialChild(
                  child: Icon(Icons.camera),
                  label: 'Take Attendance',
                  labelStyle: TextStyle(fontSize: 16),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakeAttendance(
                            groupName: widget.groupName,
                            groupId: widget.groupId,
                          ),
                        ));
                  },
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
                        PopupMenuButton(
                          elevation: 10,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSortOption = 'nameAscending';
                                  });
                                },
                                child: ListTile(
                                  leading:
                                      Icon(CupertinoIcons.arrow_up_circle_fill),
                                  title: Text("By Name"),
                                ),
                              )),
                              PopupMenuItem(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSortOption = 'nameDescending';
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(
                                      CupertinoIcons.arrow_down_circle_fill),
                                  title: Text("By Name"),
                                ),
                              )),
                              PopupMenuItem(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSortOption = 'presentDaysAscending';
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(CupertinoIcons.arrow_up_circle),
                                  title: Text("By Present Days"),
                                ),
                              )),
                              PopupMenuItem(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSortOption =
                                        'presentDaysDescending';
                                  });
                                },
                                child: ListTile(
                                  leading:
                                      Icon(CupertinoIcons.arrow_down_circle),
                                  title: Text("By Present Days"),
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
                    Expanded(
                      child: ListView.builder(
                          itemCount: attendeeList.length,
                          // attendeeVariable.attendeeName.length,

                          itemBuilder: (context, index) {
                            // final sortedAttendees = attendeeList;
                            return ManageAttendeeTile(
                                attendeeName: attendeeList[index].name,
                                groupId: widget.groupId,
                                presentDays: 0,
                                attendeeId: attendeeList[index].id,
                                onAttendeeDeleted: (attendeeId) {
                                  setState(() {
                                    attendeeList.removeWhere(
                                        (item) => item.id == attendeeId);
                                  });
                                },
                                ProfileImage:
                                    '${Endpoints.url}${attendeeList[index].profilePic}');
                          }),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
