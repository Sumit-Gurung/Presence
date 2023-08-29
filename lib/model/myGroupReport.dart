import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presence/components/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class MyGroupsReport {
//   final int groupId;
//   final String groupName;
//   final int totalStudents;
//   // final String date;
//   // final int presentAttendees;

//   MyGroupsReport({
//     required this.groupId,
//     required this.groupName,
//     required this.totalStudents,
//     // required this.date,
//     // required this.presentAttendees
//   });
//   static MyGroupsReport fromMap(Map<String, dynamic> rawMyGroupReport) {
//     return MyGroupsReport(
//       groupId: rawMyGroupReport['group']['id']!,
//       groupName: rawMyGroupReport['group']['name']!,
//       totalStudents: rawMyGroupReport['group']['totalStudent']!,
//       // date: '2023-08-2',
//       // presentAttendees: rawMyGroupReport['attendance']['presentStudent']!
//     );
//   }
// }
class MyGroupsReport {
  Group? group;
  List<Attendance>? attendance;

  MyGroupsReport({this.group, this.attendance});

  MyGroupsReport.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  int? id;
  String? name;
  int? totalStudent;

  Group({this.id, this.name, this.totalStudent});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalStudent = json['totalStudent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['totalStudent'] = this.totalStudent;
    return data;
  }
}

class Attendance {
  String? date;
  int? presentStudent;

  Attendance({this.date, this.presentStudent});

  Attendance.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    presentStudent = json['presentStudent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['presentStudent'] = this.presentStudent;
    return data;
  }
}

class MyGroupReportRepo {
  static Future<List<MyGroupsReport>> getMyGroupReport() async {
    var inst = await SharedPreferences.getInstance();
    String authToken = inst.getString('accessToken')!;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    final response = await http.get(Uri.parse(Endpoints.forMyGroupsReport),
        headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<MyGroupsReport> myGroupReports =
          List.of(data).map((e) => MyGroupsReport.fromJson(e)).toList();
      return myGroupReports;
    } else {
      throw Exception('Failed to load Report');
    }
  }
}
