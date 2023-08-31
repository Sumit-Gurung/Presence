// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/model/user.dart';
import 'package:presence/providers/Individual_attendee_provider.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/attendeeOfGroup.dart';
import 'package:http/http.dart' as http;

import '../model/attendeeOfGroup.dart';

class ManageAttendeeTile extends StatefulWidget {
  // final bool? showToogle;

  // const Individual_tile({super.key, this.showToogle});
  // const ManageAttendeeTile({Key? key}) : super(key: key);
  final int attendeeId;
  // final int groupIndex;
  final String attendeeName;
  final int attendeeIndex;
  final int groupId;
  final ValueChanged<int> onAttendeeDeleted;

  final String profileImage;
  final String attendeeEmail;
  final String phoneNumber;

  const ManageAttendeeTile({
    super.key,
    required this.attendeeName,
    required this.groupId,
    required this.attendeeEmail,
    required this.onAttendeeDeleted,
    required this.attendeeId,
    required this.profileImage,
    required this.phoneNumber,
    required this.attendeeIndex,
    // required this.groupIndex
  });
  // final String attendeeName;

  // const ManageAttendeeTile({super.key, required this.index});

  @override
  State<ManageAttendeeTile> createState() => _ManageAttendeeTileState();
}

class _ManageAttendeeTileState extends State<ManageAttendeeTile> {
  List<UserDetails> attendeeList = [];
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
  }

  // callNumber() {
  //   const number = '08592119XXXX'; //set the number here
  //   FlutterPhoneDirectCaller.callNumber(number);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AttendeeProvider, GroupProvider>(
      builder: (context, AttendeeVariable, groupProviderVariable, child) {
        return Container(
          margin: EdgeInsets.fromLTRB(8, 0, 8, 25),
          width: double.maxFinite,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 1,
                color: Colors.grey.shade500,
                offset: Offset(2, 6)),
          ]),
          // height: 80,

          child: Slidable(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.tilebackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                  // title: Text(
                  // "${AttendeeVariable.attendeeName[widget.index]["name"]}"),
                  title: Text(widget.attendeeName),
                  subtitle: Text("${widget.attendeeEmail}"),
                  //
                  leading: CircleAvatar(
                    radius: 15,
                    // backgroundImage: (attendeeList[widget.attendeeIndex]
                    //             .profilePic !=
                    //         null)
                    //     ? NetworkImage(
                    //             '${Endpoints.url}${attendeeList[widget.attendeeIndex].profilePic}')
                    //         as ImageProvider
                    //     : AssetImage("assets/images/avatar.jpg"),

                    backgroundImage: NetworkImage(widget.profileImage),
                  ),
                  trailing: Icon(Icons.room_preferences_outlined)),
            ),
            endActionPane: ActionPane(
              children: [
                SlidableAction(
                  // padding: EdgeInsets.all(10),
                  onPressed: (context) async {
                    Map tosend = {
                      "action": "remove",
                      "user": "${widget.attendeeId}",
                      "group": widget.groupId
                    };
                    var inst = await SharedPreferences.getInstance();
                    String accessToken = inst.getString('accessToken')!;

                    var headers = {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $accessToken',
                    };

                    var response = await http.post(
                        Uri.parse(Endpoints.forAddingOrRemovingAttendeeToGroup),
                        headers: headers,
                        body: jsonEncode(tosend));
                    // print(response.body);
                    print(
                        "The staus code when user is deleted is:  ${response.statusCode}");
                    // var responseDecoded = jsonDecode(response.body);
                    // print(responseDecoded['message']);

                    var responseToShow = jsonDecode(response.body);
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      widget.onAttendeeDeleted(widget.attendeeId);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 2110),
                          backgroundColor: AppColors.authBasicColor,
                          content: Text(
                            '${responseToShow['message']}',
                            style: TextStyle(color: Colors.white),
                          )));
                    } else {
                      print(
                          "Unsucessfull with statuscode: ${response.statusCode} ");
                    }
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) async {
                    // launch('tel://${widget.phoneNumber}');
                    await FlutterPhoneDirectCaller.callNumber(
                        widget.phoneNumber);
                  },
                  backgroundColor: Color.fromARGB(255, 33, 202, 89),
                  foregroundColor: Colors.white,
                  icon: Icons.phone,
                  label: 'Contact',
                ),
              ],
              motion: ScrollMotion(),
            ),
          ),
        );
      },
    );
  }
}
