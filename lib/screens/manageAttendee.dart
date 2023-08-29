import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import "package:http_parser/http_parser.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presence/components/constant.dart';
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
        uploadImage(image!);
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
//create mutipart req
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Endpoints.forUploadPhotoForAttendance),
    );
//add headers to req
    request.headers.addAll(headers);

//imageFile is opened to obtain stream of its bytes and likewise for length
    var stream = http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();

    //add field to req
    request.fields['group'] = widget.groupId.toString();

//The http.MultipartFile class is used to create a new multipart file. It takes the field name 'image',
//the byte stream of the image, its length, the filename, and the content type of the image file.
// The lookupMimeType function is used to determine the content type based on the file extension.
    var multipartFile = http.MultipartFile(
      'captureImage',
      stream,
      length,
      filename: imageFile.path,
      contentType: MediaType.parse(lookupMimeType(imageFile.path)!),
    );
//now created multipart file is add to the request and finally it is sent
    request.files.add(multipartFile);

    var response = await http.Response.fromStream(await request.send());
    var responsetoShow = jsonDecode(response.body)['message'];

    if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded! for attendance');

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$responsetoShow")));
      // Navigator.of(context).pop();
    } else {
      // Error occurred while uploading image
      print('Image upload failed.');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakeAttendance(
              groupName: widget.groupName,
              groupId: widget.groupId,
              presentAttendeeIdList: [1, 5],
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
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Manage Attendee',
                        style: TextStyle(
                            fontSize: 27,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                                    attendeeList = sortAttendees();
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(
                                      CupertinoIcons.arrow_down_circle_fill),
                                  title: Text("By Name"),
                                ),
                              )),
                              // PopupMenuItem(
                              //     child: GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       selectedSortOption = 'presentDaysAscending';
                              //     });
                              //   },
                              //   child: ListTile(
                              //     leading: Icon(CupertinoIcons.arrow_up_circle),
                              //     title: Text("By Present Days"),
                              //   ),
                              // )),
                              // PopupMenuItem(
                              //     child: GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       selectedSortOption =
                              //           'presentDaysDescending';
                              //     });
                              //   },
                              //   child: ListTile(
                              //     leading:
                              //         Icon(CupertinoIcons.arrow_down_circle),
                              //     title: Text("By Present Days"),
                              //   ),
                              // )),
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
                        )
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
                                attendeeIndex: index,
                                profileImage:
                                    '${attendeeList[index].profilePic}');
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
