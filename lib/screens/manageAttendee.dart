import 'dart:convert';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';
import "package:http_parser/http_parser.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/myAppBar.dart';
import 'package:presence/model/attendeeOfGroup.dart';
import 'package:presence/model/user.dart';
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
  List<dynamic> usersForMultipleSelect = [];
  List<int> selectedUserIds = [];
  TextEditingController searchController = TextEditingController();

  dynamic selectedUser;

  TextEditingController nameAddController = TextEditingController();
  bool isSwitch = false;
  String selectedSortOption = '';
  List<UserDetails> attendeeList = [];
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

//for searching: fetchAllusers(),filterUSers(),selectedUser()
  Future<void> fetchAllUsers() async {
    final response = await http.get(Uri.parse(Endpoints.forAllUsers));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['users'];
        usersForMultipleSelect =
            users.map((e) => UserDetails.fromMap(e)).toList();
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
          ? users
          : users
              .where((user) =>
                  user['name'].toLowerCase().contains(query.toLowerCase()) ||
                  user['email'].toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  void selectUser(dynamic user) {
    setState(() {
      // isSelected = true;
      selectedUser = user;
      if (selectedUserIds.contains(user['id'])) {
        selectedUserIds.remove(user['id']);
      } else {
        selectedUserIds.add(user['id']);
      }

      searchController.text = user['name'];
    });
  }

//for sorting
  List<UserDetails> sortAttendees() {
    switch (selectedSortOption) {
      case 'nameAscending':
        return attendeeList..sort((a, b) => a.name.compareTo(b.name));

      case 'nameDescending':
        return attendeeList..sort((a, b) => b.name.compareTo(a.name));

      default:
        return attendeeList;
    }
  }

  //return UserDetails object when id is given
  UserDetails getUserDetailsById(int userId) {
    UserDetails foundUser = usersForMultipleSelect.firstWhere(
      (user) => user.id == userId,
    );
    return foundUser;
  }

  //for Image(attendance)
  File? image;

  Future pickImageAndUpload(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        return;
      } else {
        final imageFile = File(pickedImage.path);
        setState(() {
          image = imageFile;
        });
        await uploadImage(image!);
      }
    } catch (e) {
      print('Exception Caught: $e');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var inst = await SharedPreferences.getInstance();

    String accessToken = inst.getString('accessToken')!;

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Endpoints.forUploadPhotoForAttendance),
    );
    request.headers.addAll(headers);
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    request.fields.addAll({'group': widget.groupId.toString()});
    var multipartFile = http.MultipartFile(
      'captureImage',
      stream,
      length,
      filename: imageFile.path,
      contentType: MediaType.parse(lookupMimeType(imageFile.path)!),
    );
    request.files.add(multipartFile);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 350,
            width: 350,
            child: Lottie.asset('assets/animations/photoProcess.json'),
          ),
        );
      },
    );
    var response = await http.Response.fromStream(await request.send());
    Navigator.of(context).pop();
    if (response.statusCode == 201) {
      var decodedResponse = jsonDecode(response.body);
      var responsetoShow = decodedResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responsetoShow),
      ));
      List<int> presentAttendeeIdList =
          (decodedResponse['present_users'] as List<dynamic>)
              .map((e) => e as int)
              .toList();

      print("Detected ${presentAttendeeIdList.length} students.");

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakeAttendance(
              groupName: widget.groupName,
              groupId: widget.groupId,
              imageFile: imageFile,
              presentAttendeeIdList: presentAttendeeIdList,
            ),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong processing this request."),
      ));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakeAttendance(
              groupName: widget.groupName,
              groupId: widget.groupId,
              imageFile: imageFile,
              presentAttendeeIdList: [],
            ),
          ));
    }
  }

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
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              contentPadding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                              backgroundColor: AppColors.backgroundColor,
                              title: Text('Add Attendee'),
                              content: Container(
                                height: 400,
                                width: double.maxFinite,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.search,
                                            size: 35,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: TextField(
                                                onChanged: (value) {
                                                  setState101(
                                                    () {
                                                      filterUsers(value);
                                                    },
                                                  );
                                                },
                                                decoration: InputDecoration(
                                                    hintText: 'Search User....',
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: filteredUsers.length,
                                        itemBuilder: (context, index) {
                                          final user = filteredUsers[index];
                                          return Container(
                                            margin: EdgeInsets.fromLTRB(
                                                5, 0, 5, 12),
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .tilebackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: isSelected
                                                    ? Border.all(
                                                        color: Colors.green)
                                                    : null,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 7,
                                                      spreadRadius: 1,
                                                      color:
                                                          Colors.grey.shade500,
                                                      offset: Offset(2, 6)),
                                                ]),
                                            child: ListTile(
                                                onTap: () {
                                                  setState101(
                                                    () {
                                                      selectUser(user);
                                                    },
                                                  );
                                                },
                                                leading: CircleAvatar(
                                                  backgroundImage: user[
                                                              'profilePic'] !=
                                                          null
                                                      ? NetworkImage(
                                                              "${Endpoints.url}${user['profilePic']}")
                                                          as ImageProvider
                                                      : AssetImage(
                                                          "assets/images/avatar.jpg"),
                                                ),
                                                title: Text(user['name']),
                                                subtitle: Text(
                                                  user['email'],
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                ),
                                                trailing: selectedUserIds
                                                        .contains(user['id'])
                                                    ? Icon(
                                                        CupertinoIcons
                                                            .check_mark_circled_solid,
                                                        color: Colors.green,
                                                      )
                                                    : Icon(CupertinoIcons
                                                        .person_add)),
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
                                    child: Text(
                                      'cancel',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.authBasicColor),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      Map tosend = {
                                        "action": "add",
                                        "user": selectedUserIds,
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
                                      var responsetoShow =
                                          jsonDecode(response.body)['message'];
                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        for (int selectedUserId
                                            in selectedUserIds) {
                                          UserDetails userSelectedInBulk =
                                              getUserDetailsById(
                                                  selectedUserId);
                                          // UserDetails justCreated =
                                          //     UserDetails.fromMap(selectedUser);
                                          attendeeList.add(userSelectedInBulk);
                                        }
                                        // UserDetails justCreated =
                                        //     UserDetails.fromMap(selectedUser);
                                        // attendeeList.add(justCreated);
                                        selectedUserIds = [];
                                        setState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    AppColors.authBasicColor,
                                                duration: Duration(
                                                    milliseconds: 1400),
                                                content:
                                                    Text('$responsetoShow')));
                                      } else {
                                        selectedUserIds = [];
                                        setState(() {});

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    AppColors.authBasicColor,
                                                duration: Duration(
                                                    milliseconds: 1400),
                                                content:
                                                    Text('$responsetoShow ')));
                                        print(
                                            "Unsucessfull with statuscode: ${response.statusCode} ");
                                      }

                                      // print(response.body);

                                      // groupProviderVariable.addAttendeeToGroup(
                                      //     selectedUser['name'],
                                      //     widget.groupIndex);

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'ok',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.authBasicColor),
                                    )),
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
                  label: 'Take Attendance (Use camera)',
                  labelStyle: TextStyle(fontSize: 16),
                  onTap: () {
                    // showImagePickerOptions(context);

                    pickImageAndUpload(ImageSource.camera);
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.photo_album_rounded),
                  label: 'Take Attendance (Gallery)',
                  labelStyle: TextStyle(fontSize: 16),
                  onTap: () {
                    pickImageAndUpload(ImageSource.gallery);
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                MyAppBar(title: 'Manage Attendee'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // MyAppBar(title: 'as'),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                widget.groupName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            PopupMenuButton(
                              elevation: 10,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortOption = 'nameAscending';
                                        attendeeList = sortAttendees();
                                      });
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                          CupertinoIcons.arrow_up_circle_fill),
                                      title: Text("By Name"),
                                    ),
                                  )),
                                  PopupMenuItem(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortOption = 'nameDescending';
                                        attendeeList = sortAttendees();
                                      });
                                    },
                                    child: ListTile(
                                      leading: Icon(CupertinoIcons
                                          .arrow_down_circle_fill),
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
                                child: Image.asset(
                                    'assets/images/preferences.png'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
                                    attendeeEmail: attendeeList[index].email,
                                    attendeeId: attendeeList[index].id,
                                    onAttendeeDeleted: (attendeeId) {
                                      setState(() {
                                        attendeeList.removeWhere(
                                            (item) => item.id == attendeeId);
                                      });
                                    },
                                    attendeeIndex: index,
                                    phoneNumber:
                                        attendeeList[index].phoneNumber,
                                    profileImage:
                                        '${attendeeList[index].profilePic}');
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
