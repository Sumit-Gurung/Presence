// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

import '../components/homeScreenGroupCard.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllUsers();
  }

  List groupList = [
    ['Math-iii', 'assets/images/mathh.png', 'No.of Members: 21'],
    ['Programming', 'assets/images/programming.png', 'No.of of Members: 13'],
    ['Data Mining', 'assets/images/dataMinig.png', 'No.of of Members: 33']
  ];

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
            //discover new...

            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Join Groups Now',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            // search bar
            SizedBox(
              height: 15,
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
                                decoration: InputDecoration(
                                    hintText: 'Type bruhh..',
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
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'For You',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),

            //cards

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: Container(
                height: 200,
                // color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HomePageGroupCard(
                      iconPath: groupList[index][1],
                      jobTitle: groupList[index][0],
                      horlyRate: groupList[index][2],
                    );
                  },
                  itemCount: groupList.length,
                ),
              ),
            ),
            //recently added
            SizedBox(
              height: 8,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Recently Added',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
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
                      title: Text(user["name"]),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${Endpoints.url}${user['profilePic']}" ??
                                'https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
                      ),
                      subtitle: Text(user['email']),
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
