import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presence/components/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetNotification {
  int? id;
  int? sender;
  DateTime? sendAt;
  bool? read;
  int? group;

  GetNotification({this.id, this.sender, this.sendAt, this.read, this.group});

  GetNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];

    sendAt = DateTime.parse(json['send_at']);
    read = json['read'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender'] = this.sender;
    data['send_at'] = this.sendAt;
    data['read'] = this.read;
    data['group'] = this.group;
    return data;
  }
}

class GetNotificationRepo {
  static Future<List<GetNotification>> getNotification() async {
    var inst = await SharedPreferences.getInstance();
    String authToken = inst.getString('accessToken')!;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    final response = await http.get(Uri.parse(Endpoints.forGetNotification),
        headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<GetNotification> notificationList =
          List.of(data).map((e) => GetNotification.fromJson(e)).toList();
      return notificationList;
    } else {
      throw Exception('Failed to load Report');
    }
  }
}
