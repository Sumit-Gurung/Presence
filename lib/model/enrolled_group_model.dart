import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../components/constant.dart';

import 'package:http/http.dart' as http;

class EnrolledGroup {
  final String name;
  final int id;
  final DateTime date;
  final List<User> users; // New property to store the list of users

  EnrolledGroup({
    required this.id,
    required this.name,
    required this.date,
    required this.users,
  });

  static EnrolledGroup fromMap(Map<String, dynamic> rawEnrolledGroup) {
    final List<User> userList = (rawEnrolledGroup['users'] as List)
        .map((user) => User(
              id: user['id'],
              name: user['name'],
              email: user['email'],
              phoneNumber: user['phoneNumber'],
            ))
        .toList();

    return EnrolledGroup(
      id: rawEnrolledGroup['id']!,
      name: rawEnrolledGroup['name']!,
      date: DateTime.parse(rawEnrolledGroup['created_at']!),
      users: userList,
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class EnrolledGroupRepo {
  static Future<List<EnrolledGroup>> getEnrolledGroups() async {
    var inst = await SharedPreferences.getInstance();
    String authToken = inst.getString('accessToken')!;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    final response = await http
        .get(Uri.parse(Endpoints.forShowingEnrolledGroups), headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final enrolledGroupData = data['involvement'];
      final List<EnrolledGroup> myEnrolledGroups = List.of(enrolledGroupData)
          .map((e) => EnrolledGroup.fromMap(e))
          .toList();
      return myEnrolledGroups;
    } else {
      throw Exception('Failed to load EnrolledGroups');
    }
  }
}
