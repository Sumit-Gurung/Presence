// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/providers/Individual_attendee_provider.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/attendeeOfGroup.dart';
import 'package:http/http.dart' as http;

class ManageAttendeeTile extends StatefulWidget {
  // final bool? showToogle;

  // const Individual_tile({super.key, this.showToogle});
  // const ManageAttendeeTile({Key? key}) : super(key: key);
  final int attendeeId;
  // final int groupIndex;
  final String attendeeName;
  final String ProfileImage;
  final int groupId;
  final ValueChanged<int> onAttendeeDeleted;
  final int presentDays;

  const ManageAttendeeTile({
    super.key,
    required this.attendeeName,
    required this.groupId,
    required this.presentDays,
    required this.onAttendeeDeleted,
    required this.attendeeId,
    required this.ProfileImage,
    // required this.groupIndex
  });
  // final String attendeeName;

  // const ManageAttendeeTile({super.key, required this.index});

  @override
  State<ManageAttendeeTile> createState() => _ManageAttendeeTileState();
}

class _ManageAttendeeTileState extends State<ManageAttendeeTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AttendeeProvider, GroupProvider>(
      builder: (context, AttendeeVariable, groupProviderVariable, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 25),
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
                  subtitle: Text("Present Days: ${widget.presentDays}"),
                  //
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(widget.ProfileImage ??
                        'https://www.google.com/search?q=avatar+url&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiegO6ty-X8AhXMI7cAHZr3AU8Q_AUoAXoECAEQAw&biw=1536&bih=754&dpr=1.25#imgrc=YYYLguVFuko0CM'),
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
                      "user": widget.attendeeId,
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
                    print(response.body);
                    print(response.statusCode);
                    // var responseDecoded = jsonDecode(response.body);
                    // print(responseDecoded['message']);
                    print('print huna parne ho!');
                    var responseToShow = jsonDecode(response.body);
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      widget.onAttendeeDeleted(widget.attendeeId);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${responseToShow['message']}')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${responseToShow['error']}')));
                      print(
                          "Unsucessfull with statuscode: ${response.statusCode} ");
                    }

                    // print(response.body);
                    // setState(() {
                    //   groupProviderVariable.deleteAttendeeFromGroup(
                    //       widget.groupIndex,
                    //       widget.attendeeId,
                    //       widget.attendeeName);
                    // });
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: null,
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
