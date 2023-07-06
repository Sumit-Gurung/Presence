import 'dart:convert';

import '../components/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Group {
  final String name;
  final DateTime created_at;
  final int id;

  Group({required this.name, required this.created_at, required this.id});

  static Group fromMap(Map<String, dynamic> rawGroup) {
    return Group(
      name: rawGroup['name']!,
      created_at: DateTime.parse(rawGroup['created_at']!),
      id: rawGroup['id']!,
    );
  }
}

class MyGroupRepository {
  static Future<List<Group>> getGroup() async {
    var inst = await SharedPreferences.getInstance();
    String authToken = inst.getString('accessToken')!;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    final response =
        await http.get(Uri.parse(Endpoints.forShowMyGroups), headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<Group> myAllGroups =
          List.of(data).map((e) => Group.fromMap(e)).toList();
      return myAllGroups;
    } else {
      throw Exception('Failed to load groups');
    }
  }
}
