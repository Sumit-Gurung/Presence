import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/constant.dart';

class EnrolledGroupReport {
  final String name;
  final int totalDays;
  final int presentDays;

  EnrolledGroupReport(
      {required this.name, required this.presentDays, required this.totalDays});
  static EnrolledGroupReport fromMap(
      Map<String, dynamic> rawEnrolledGroupReport) {
    return EnrolledGroupReport(
        name: rawEnrolledGroupReport['group']['name']!,
        presentDays: rawEnrolledGroupReport['presentDays']!,
        totalDays: rawEnrolledGroupReport['totalDays']!);
  }
}

class EnrolledGroupReportRepo {
  static Future<List<EnrolledGroupReport>> getEnrolledGroupReport() async {
    var inst = await SharedPreferences.getInstance();
    String authToken = inst.getString('accessToken')!;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    final response = await http
        .get(Uri.parse(Endpoints.forEnrolledGroupsReport), headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<EnrolledGroupReport> enrolledGrpReports =
          List.of(data).map((e) => EnrolledGroupReport.fromMap(e)).toList();
      return enrolledGrpReports;
    } else {
      throw Exception('Failed to load Report');
    }
  }
}
