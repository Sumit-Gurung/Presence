import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
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
  @override
  String selectedSortOption = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                            leading: Icon(CupertinoIcons.arrow_up_circle_fill),
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
                            leading:
                                Icon(CupertinoIcons.arrow_down_circle_fill),
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
                              selectedSortOption = 'presentDaysDescending';
                            });
                          },
                          child: ListTile(
                            leading: Icon(CupertinoIcons.arrow_down_circle),
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
                  Expanded(
                    child: Text(
                      'MEMBERS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
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
                itemCount: widget.userlist.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 14),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.tilebackgroundColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(widget.userlist[index].name),
                      subtitle: Text(widget.userlist[index].email),
                      trailing: Icon(Icons.phone),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
