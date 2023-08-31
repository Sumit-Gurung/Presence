import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/myAppBar.dart';
import 'package:presence/model/enrolled_group_model.dart';

class EnrolledMembers extends StatefulWidget {
  final String groupName;
  final List<User> userlist;

  const EnrolledMembers(
      {super.key, required this.groupName, required this.userlist});
  // const EnrolledMembers({super.key});

  @override
  State<EnrolledMembers> createState() => _EnrolledMembersState();
}

class _EnrolledMembersState extends State<EnrolledMembers> {
  String selectedSortOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(title: 'Enrolled Members'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    // attendeeList = sortAttendees();
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
                                    // attendeeList = sortAttendees();
                                  });
                                },
                                child: ListTile(
                                  leading: Icon(
                                      CupertinoIcons.arrow_down_circle_fill),
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: widget.userlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.tilebackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: -2,
                                    color: Colors.grey.shade500,
                                    offset: Offset(1, 6)),
                              ],
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(widget.userlist[index].name),
                            subtitle: Text(widget.userlist[index].email),
                            trailing: IconButton(
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      widget.userlist[index].phoneNumber);
                                },
                                icon: Icon(Icons.phone)),
                          ),
                        );
                      },
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
