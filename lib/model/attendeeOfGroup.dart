import 'dart:convert';
// import 'dart:html';

import 'package:presence/components/constant.dart';
import 'package:presence/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttendeeOfGroupRepo {
  static Future<List<UserDetails>> getAttendeeOfGroup(int groupKoId) async {
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

      List<UserDetails> myAllGroups =
          List.of(userData).map((e) => UserDetails.fromMap(e)).toList();
      return myAllGroups;
    } else {
      throw Exception('Failed to load Attendees of groups');
    }
  }
}
