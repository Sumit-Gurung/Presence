import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/Enrolled_group_tile.dart';
// import 'package:presence/components/constant.dart';

import 'package:presence/model/enrolled_group_model.dart';
import 'package:presence/model/user.dart';
import 'package:presence/screens/enrolledMembers.dart';

import '../model/allUsers.dart';

class EnrolledGroupPage extends StatefulWidget {
  const EnrolledGroupPage({super.key});

  @override
  State<EnrolledGroupPage> createState() => _EnrolledGroupPageState();
}

class _EnrolledGroupPageState extends State<EnrolledGroupPage> {
  List<EnrolledGroup> enrolledGroups = [];
  // String creatorNamme = '';
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

  Future<String> getCreatorName(int id) async {
    try {
      final List<UserDetails> allUsers = await AllUsersRepository.getAllUsers();
      final user = allUsers.firstWhere(
        (user) => user.id == id,
        orElse: () => UserDetails(
            id: 99,
            email: 'dsa@gma.com',
            name: 'random',
            phoneNumber: '9874563210',
            profilePic: 'saddas'),
      );

      return user.name;
    } catch (e, s) {
      // Handle any errors or exceptions that occur during the retrieval
      print('Error: $e');
      print(s);
      return 'Error retrieving user';
    }
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
          return FutureBuilder<String>(
            future: getCreatorName(enrolledGroups[index].creatorId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final createrName = snapshot.data;
                return EnrolledGroupTile(
                  groupName: enrolledGroups[index].name,
                  createrName: createrName!,
                  ontap: () {
                    print('tap vacha');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnrolledMembers(
                          userlist: enrolledGroups[index].users,
                          groupName: enrolledGroups[index].name,
                        ),
                      ),
                    );
                  },
                  date:
                      '${DateFormat.yMMMd().add_jm().format(enrolledGroups[index].date)}',
                  totalMembers: enrolledGroups[index].users.length,
                );
              }
            },
          );
        },
      ),
    );
  }
}
