// import 'package:flutter/material.dart';
// import 'package:presence/model/mygroups.dart';

// class MyGroupsShow extends StatefulWidget {
//   const MyGroupsShow({super.key});

//   @override
//   State<MyGroupsShow> createState() => _MyGroupsShowState();
// }

// class _MyGroupsShowState extends State<MyGroupsShow> {
//   @override
//   void initState() {
//     super.initState();
//     late Future<List<MyGroups>> myGroupsList;

//     myGroupsList = MyGroupRepository.getMyGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           FutureBuilder(
//             future: myGroupsList,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text('${snapshot.error} found'),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.done) {
//                 final datafromSnapShot = snapshot.data;
//                 final length = datafromSnapShot!.length;

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text('${datafromSnapShot[index].name}'),
//                     );
//                   },
//                 );
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           )
//         ],
//       )),
//     );
//   }
// }
