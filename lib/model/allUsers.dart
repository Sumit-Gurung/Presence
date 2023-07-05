// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presence/components/constant.dart';

class AllUsersRepository {
  static Future<List<AllUsers>> getAllUsers() async {
    final response = await http.get(Uri.parse(Endpoints.forAllUsers));
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var newdata = data["users"];
      List<AllUsers> alluser =
          List.of(newdata).map((e) => AllUsers.fromMap(e)).toList();
      return alluser;
    } else {
      throw Exception('Failed to load company details');
    }
  }
}

class AllUsers {
  final int id;
  final String email;
  final String name;
  final String phoneNumber;
  final String profilePic;

  AllUsers(
      {required this.id,
      required this.email,
      required this.name,
      required this.phoneNumber,
      required this.profilePic});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
    };
  }

  factory AllUsers.fromMap(Map<String, dynamic> map) {
    return AllUsers(
      id: map['id'] as int,
      email: map['email'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePic: map['profilePic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllUsers.fromJson(String source) =>
      AllUsers.fromMap(json.decode(source) as Map<String, dynamic>);
}
