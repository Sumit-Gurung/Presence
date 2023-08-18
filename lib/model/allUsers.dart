// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presence/components/constant.dart';
import 'package:presence/model/user.dart';

class AllUsersRepository {
  static Future<List<UserDetails>> getAllUsers() async {
    final response = await http.get(Uri.parse(Endpoints.forAllUsers));
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var newdata = data["users"];
      List<UserDetails> alluser =
          List.of(newdata).map((e) => UserDetails.fromMap(e)).toList();
      return alluser;
    } else {
      throw Exception('Failed to load company details');
    }
  }
}

// class AllUsers {
//   final int id;
//   final String email;
//   final String name;
//   final String phoneNumber;
//   final String profilePic;

//   AllUsers(
//       {required this.id,
//       required this.email,
//       required this.name,
//       required this.phoneNumber,
//       required this.profilePic});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'email': email,
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'profilePic': profilePic,
//     };
//   }

//   factory AllUsers.fromMap(Map<String, dynamic> map) {
//     print("proiflepic" + map['profilePic']);
//     return AllUsers(
//       id: map['id'] as int,
//       email: map['email'] as String,
//       name: map['name'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       profilePic: map['profilePic'] != null
//           ? Endpoints.url + map['profilePic']
//           : 'https://www.havahart.com/media/wysiwyg/hh/cms/lc/mice/hh-animals-mouse-1.png',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AllUsers.fromJson(String source) =>
//       AllUsers.fromMap(json.decode(source) as Map<String, dynamic>);
// }

class UserRepository {
  static Future<String> getUserNameById(int id) async {
    try {
      final List<UserDetails> allUsers = await AllUsersRepository.getAllUsers();
      final user = allUsers.firstWhere(
        (UserDetails user) => user.id == id,
        orElse: () => UserDetails(
            id: 99,
            email: 'dsa@gma.com',
            name: 'random',
            phoneNumber: '9874563210',
            profilePic: 'saddas'),
      );

      if (user != null) {
        return user.name;
      } else {
        return 'User not found';
      }
    } catch (e) {
      // Handle any errors or exceptions that occur during the retrieval
      print('Error: $e');
      return 'Error retrieving user';
    }
  }
}
