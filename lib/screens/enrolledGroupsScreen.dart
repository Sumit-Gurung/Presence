import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/Enrolled_group_tile.dart';
// import 'package:presence/components/constant.dart';

import 'package:presence/model/enrolled_group_model.dart';
import 'package:presence/screens/enrolledMembers.dart';

class EnrolledGroupPage extends StatefulWidget {
  const EnrolledGroupPage({super.key});

  @override
  State<EnrolledGroupPage> createState() => _EnrolledGroupPageState();
}

class _EnrolledGroupPageState extends State<EnrolledGroupPage> {
  List<EnrolledGroup> enrolledGroups = [];
  // List<dynamic> enrolledgroups = [];
  // List<dynamic> filteredEnrolledgroups = [];
  @override
  void initState() {
    super.initState();
    // fetchEnrolledGroups();

    EnrolledGroupRepo.getEnrolledGroups().then((value) {
      setState(() {
        enrolledGroups = value;
      });
    });
  }

  // Future<void> fetchEnrolledGroups() async {
  //   var inst = await SharedPreferences.getInstance();
  //   String authToken = inst.getString('accessToken')!;

  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $authToken',
  //   };
  //   final response = await http
  //       .get(Uri.parse(Endpoints.forShowingEnrolledGroups), headers: headers);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       enrolledgroups = json.decode(response.body)['involvement'];
  //       filteredEnrolledgroups = enrolledgroups;
  //     });
  //   } else {
  //     print('Failed to load data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: enrolledGroups.length,
        itemBuilder: (context, index) {
          return EnrolledGroupTile(
              groupName: enrolledGroups[index].name,
              createrName: 'Sumit Gurung',
              ontap: () {
                print('tap vacha');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnrolledMembers(
                          userlist: enrolledGroups[index].users,
                          groupName: enrolledGroups[index].name),
                    ));
              },
              date:
                  '${DateFormat.yMMMd().add_jm().format(enrolledGroups[index].date)}',
              totalMembers: enrolledGroups[index].users.length);
        },
      ),
    );
  }
}
