// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:presence/components/constant.dart';

// class Test03 extends StatefulWidget {
//   @override
//   _Test03State createState() => _Test03State();
// }

// class _Test03State extends State<Test03> {
//   List<dynamic> users = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//     print("after fetching");
//   }

//   Future<void> fetchUsers() async {
//     print('yaha samma acha');
//     final response = await http.get(Uri.parse('${Endpoints.forAllUsers}'));
//     print(response.body);

//     if (response.statusCode == 200) {
//       setState(() {
//         users = json.decode(response.body)['users'];
//       });
//     } else {
//       print('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ALL USER LIST'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   final user = users[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(
//                           "${Endpoints.url} ${user['profilePic']}" ??
//                               'https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
//                     ),
//                     title: Text(user['name']),
//                     subtitle: Text(user['email']),
//                     trailing: Text(user['phoneNumber']),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
