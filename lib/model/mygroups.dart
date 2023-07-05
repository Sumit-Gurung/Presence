// import 'dart:convert';

// import '../components/constant.dart';
// import 'package:http/http.dart' as http;

// class MyGroupRepository {
//   static Future<List<MyGroups>> getMyGroups() async {
//     final response = await http.get(Uri.parse(Endpoints.forShowMyGroups));
//     if (response.statusCode == 201 || response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       List<MyGroups> myAllGroups =
//           List.of(data).map((e) => MyGroups.fromMap(e)).toList();
//       return myAllGroups;
//     } else {
//       throw Exception('Failed to load company details');
//     }
//   }
// }

// class MyGroups {
//   final String name;
//   final String created_at;

//   MyGroups(this.name, this.created_at);
// }
