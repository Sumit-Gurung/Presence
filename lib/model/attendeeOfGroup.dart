import 'dart:convert';
// import 'dart:html';

import 'package:presence/components/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttendeeOfGroup {
  final String name;
  final int id;
  final String email;
  final String phoneNumber;
  final String? profilePic;

  AttendeeOfGroup(
      {required this.name,
      required this.id,
      required this.email,
      required this.phoneNumber,
      required this.profilePic});

  //can we do as factory AttendeeOfGroup.fromMap(){
  //return AttendeeGroup();}

  static AttendeeOfGroup fromMap(Map<String, dynamic> rawAttendee) {
    return AttendeeOfGroup(
        name: rawAttendee['name']!,
        id: rawAttendee['id']!,
        email: rawAttendee['email']!,
        phoneNumber: rawAttendee['phoneNumber']!,
        profilePic: rawAttendee['profilePic']);
  }
}

class AttendeeOfGroupRepo {
  static Future<List<AttendeeOfGroup>> getAttendeeOfGroup(int groupKoId) async {
    var inst = await SharedPreferences.getInstance();
    String authToken = inst.getString('accessToken')!;
    // int groupId = inst.getInt('groupId')!;

    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $authToken"
    };

    // Map toSend = {"group": groupId};

    final response = await http.get(
      Uri.parse('${Endpoints.forShowingAttendeeOfGroup}$groupKoId'),
      headers: headers,
      // body: jsonEncode(toSend)
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userData = data["attendees"];

      List<AttendeeOfGroup> myAllGroups =
          List.of(userData).map((e) => AttendeeOfGroup.fromMap(e)).toList();
      return myAllGroups;
    } else {
      throw Exception('Failed to load Attendees of groups');
    }
  }
}
