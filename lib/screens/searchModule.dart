// // import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:presence/components/constant.dart';

// class SearchModule extends StatefulWidget {
//   @override
//   _SearchModuleState createState() => _SearchModuleState();
// }

// class _SearchModuleState extends State<SearchModule> {
//   List<dynamic> users = [];
//   List<dynamic> filteredUsers = [];

//   dynamic selectedUser;
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }

//   Future<void> fetchUsers() async {
//     final response = await http.get(Uri.parse(Endpoints.forAllUsers));

//     if (response.statusCode == 200) {
//       setState(() {
//         users = json.decode(response.body)['users'];
//         filteredUsers = users;
//       });
//     } else {
//       // Handle error if necessary
//       print('Failed to load data');
//     }
//   }

//   void filterUsers(String query) {
//     setState(() {
//       selectedUser = null;
//       filteredUsers = users
//           .where((user) =>
//               user['name'].toLowerCase().contains(query.toLowerCase()) ||
//               user['email'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void selectUser(dynamic user) {
//     setState(() {
//       selectedUser = user;
//       searchController.text = user['name'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       width: double.maxFinite,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               onChanged: filterUsers,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredUsers.length,
//               itemBuilder: (context, index) {
//                 final user = filteredUsers[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     width: double.maxFinite,
//                     decoration: BoxDecoration(
//                         color: AppColors.tilebackgroundColor,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 7,
//                               spreadRadius: 1,
//                               color: Colors.grey.shade500,
//                               offset: Offset(2, 6)),
//                         ]),
//                     child: ListTile(
//                         onTap: () => selectUser(user),
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                               "${Endpoints.url} ${user['profilePic']}" ??
//                                   'https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
//                           // ('${user['profilePic']}' != null)
//                           //     ? NetworkImage(
//                           //             "${Endpoints.url} ${user['profilePic']}")
//                           //         as ImageProvider
//                           //     : AssetImage('assets/images/avatar.jpg'),
//                         ),

//                         // (user.user != null &&
//                         //             user.user!.imagePath != null)
//                         //         ? NetworkImage(user.user!.imagePath!)
//                         //             as ImageProvider
//                         //         : AssetImage('assets/images/avatar.jpg'),
//                         title: Text(user['name']),
//                         subtitle: Text(
//                           user['email'],
//                           overflow: TextOverflow.fade,
//                           maxLines: 1,
//                         ),
//                         trailing: Icon(CupertinoIcons.person_add)),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SearchTile extends StatelessWidget {
//   const SearchTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//             blurRadius: 7,
//             spreadRadius: 1,
//             color: Colors.grey.shade500,
//             offset: Offset(2, 6)),
//       ]),
//       child: ListTile(),
//     );
//   }
// }
