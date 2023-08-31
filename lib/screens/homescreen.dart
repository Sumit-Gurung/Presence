// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence/components/constant.dart';

import 'package:presence/model/group.dart';
import 'package:presence/model/user.dart';

import '../components/homeScreenGroupCard.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  List<UserDetails> filteredUsers = [];
  List<Group> recommendedGroups = [];
  List<Group> filteredRecommendedGroups = [];

  @override
  void initState() {
    super.initState();
    RecommendationOfGroupRepository.getGroup().then((value) {
      setState(() {
        recommendedGroups = value;
        filteredRecommendedGroups = value;
      });
    });
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    final response = await http.get(Uri.parse(Endpoints.forAllUsers));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['users'];
        filteredUsers = users.map((e) => UserDetails.fromMap(e)).toList();
      });
    } else {
      // Handle error if necessary
      print('Failed to load data');
    }
  }

  String getCreatorName(int id) {
    try {
      final user = filteredUsers.firstWhere(
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

  //for searching

  void filtergroup(String query) {
    setState(() {
      filteredRecommendedGroups = query.isEmpty
          ? recommendedGroups
          : recommendedGroups
              .where((recomgroups) =>
                  recomgroups.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }
  // void filterUsers(String query) {
  //   setState(() {
  //     selectedUser = null;
  //     filteredUsers = query.isEmpty
  //         ? []
  //         : users
  //             .where((user) =>
  //                 user['name'].toLowerCase().contains(query.toLowerCase()) ||
  //                 user['email'].toLowerCase().contains(query.toLowerCase()))
  //             .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Join Groups Now',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // search bar
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
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
                              padding: const EdgeInsets.only(left: 25.0),
                              child: TextField(
                                onChanged: ((value) {
                                  setState(() {
                                    filtergroup(value);
                                  });
                                }),
                                decoration: InputDecoration(
                                    hintText: 'Search Group....',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/preferences.png',
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            // for you
            //discover new...

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'For You',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            //cards

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: SizedBox(
                height: 225,
                // color: Colors.amber,
                child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HomePageGroupCard(
                      groupName: filteredRecommendedGroups[index].name,
                      creatorName:
                          getCreatorName(filteredRecommendedGroups[index].id),
                      date: DateFormat('MMM d, y')
                          .format(filteredRecommendedGroups[index].created_at),
                      numberOfMembers:
                          filteredRecommendedGroups[index].numberOfAttendee,
                    );
                  },
                  itemCount: filteredRecommendedGroups.length,
                ),
              ),
            ),
            //recently added

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Recently Added',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // GridView.builder(
            //     shrinkWrap: true,
            //     itemCount: 2,
            //     gridDelegate:
            //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.all(20),
            //         // height: 10,
            //         color: Colors.red,
            //         child: GridTile(
            //             // header: Text('header'),
            //             footer: Text('footer'),
            //             child: Text('body')),
            //       );
            //     }),
            Column(
              children: [
                for (var user in filteredUsers)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42),
                              bottomRight: Radius.circular(42))),
                      tileColor: Colors.grey[200],
                      title: Text(user.name),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic!)),
                      subtitle: Text(user.email),
                    ),
                  ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
