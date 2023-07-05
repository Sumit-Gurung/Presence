import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:presence/components/constant.dart';

class Test02 extends StatefulWidget {
  @override
  _Test02State createState() => _Test02State();
}

class _Test02State extends State<Test02> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];

  dynamic selectedUser;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse(Endpoints.forAllUsers));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['users'];
      });
    } else {
      // Handle error if necessary
      print('Failed to load data');
    }
  }

  void filterUsers(String query) {
    setState(() {
      selectedUser = null;
      filteredUsers = users
          .where((user) =>
              user['name'].toLowerCase().contains(query.toLowerCase()) ||
              user['email'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // void selectUser(dynamic user) {
  //   setState(() {
  //     selectedUser = user;
  //     searchController.text = user['name'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterUsers,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return ListTile(
                  // onTap: () => selectUser(user),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['profilePic'] ?? ''),
                  ),
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Text(user['phoneNumber']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
