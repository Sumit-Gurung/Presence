// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:presence/components/constant.dart';

// class Test extends StatefulWidget {
//   const Test({
//     super.key,
//   });
//   // const Test({Key? key}) : super(key: key);

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   TextEditingController nameAddController = TextEditingController();
//   bool isSwitch = false;
//   List<PopupMenuEntry> menuList = [];
//   List<Map<String, dynamic>> attendeeName = [
//     {"name": "Chris Frome", "presentDays": 46},
//     {"name": "Roglic", "presentDays": 33},
//     {"name": "Tadej Pogacar", "presentDays": 17},
//     {"name": "Graint Thomas", "presentDays": 22},
//   ];
//   String selectedSortOption = '';
//   List<Map<String, dynamic>> sortAttendees() {
//     switch (selectedSortOption) {
//       case 'nameAscending':
//         return List<Map<String, dynamic>>.from(attendeeName)
//           ..sort((a, b) => a["name"].compareTo(b["name"]));
//       case 'nameDescending':
//         return List<Map<String, dynamic>>.from(attendeeName)
//           ..sort((a, b) => b["name"].compareTo(a["name"]));
//       case 'presentDaysAscending':
//         return List<Map<String, dynamic>>.from(attendeeName)
//           ..sort((a, b) => a["presentDays"].compareTo(b["presentDays"]));
//       case 'presentDaysDescending':
//         return List<Map<String, dynamic>>.from(attendeeName)
//           ..sort((a, b) => b["presentDays"].compareTo(a["presentDays"]));
//       default:
//         return attendeeName;
//     }
//   }

//   List<Map<String, dynamic>> dropMenuList = [
//     {
//       "selectedSortOption": "nameAscending",
//       "purpose": "Ascending By Name",
//       "icon": CupertinoIcons.arrow_up_circle_fill,
//     },
//     {
//       "selectedSortOption": "nameDecending",
//       "purpose": "Decending By Name",
//       "icon": CupertinoIcons.arrow_down_circle_fill,
//     },
//     {
//       "selectedSortOption": "presentDaysAscending",
//       "purpose": "Ascending By Present",
//       "icon": CupertinoIcons.arrow_up_circle_fill,
//     },
//     {
//       "selectedSortOption": "presentDaysDecending",
//       "purpose": "Decending By Present Days",
//       "icon": CupertinoIcons.arrow_down_circle_fill,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[300],
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     PopupMenuButton(
//                       elevation: 10,
//                       itemBuilder: (context) {
//                         return [
//                           PopupMenuItem(
//                               child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedSortOption = 'nameAscending';
//                               });
//                             },
//                             child: ListTile(
//                               leading:
//                                   Icon(CupertinoIcons.arrow_up_circle_fill),
//                               title: Text("By Name"),
//                             ),
//                           )),
//                           PopupMenuItem(
//                               child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedSortOption = 'nameDescending';
//                               });
//                             },
//                             child: ListTile(
//                               leading:
//                                   Icon(CupertinoIcons.arrow_down_circle_fill),
//                               title: Text("By Name"),
//                             ),
//                           )),
//                           PopupMenuItem(
//                               child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedSortOption = 'presentDaysAscending';
//                               });
//                             },
//                             child: ListTile(
//                               leading: Icon(CupertinoIcons.arrow_up_circle),
//                               title: Text("By Present Days"),
//                             ),
//                           )),
//                           PopupMenuItem(
//                               child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedSortOption = 'presentDaysDescending';
//                               });
//                             },
//                             child: ListTile(
//                               leading: Icon(CupertinoIcons.arrow_down_circle),
//                               title: Text("By Present Days"),
//                             ),
//                           )),
//                         ];
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Image.asset('assets/images/preferences.png'),
//                       ),
//                     ),
//                     Text(
//                       'Manage Attendee',
//                       style: TextStyle(
//                           fontSize: 25,
//                           color: Colors.grey[800],
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 100,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: attendeeName.length,
//                     itemBuilder: (context, index) {
//                       final sortedAttendees =
//                           sortAttendees(); // Obtain the sorted list

//                       final attendee = sortedAttendees[index];
//                       final name = attendee["name"];
//                       final presentDays = attendee["presentDays"];

//                       return Container(
//                         margin: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                             color: AppColors.tilebackgroundColor,
//                             borderRadius: BorderRadius.circular(12)),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Text(name[
//                                 0]), // Displaying the first letter of the name
//                           ),
//                           title: Text(name),
//                           subtitle: Text("Present Days: $presentDays"),
//                           onTap: () {
//                             // Perform action when the ListTile is tapped
//                             print("Tapped on $name");
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class CustomDropMenuItem extends StatelessWidget {
//   final VoidCallback onTap;
//   final IconData icon;
//   final String purpose;

//   const CustomDropMenuItem(
//       {super.key,
//       required this.onTap,
//       required this.icon,
//       required this.purpose});
//   // const CustomDropMenuItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuItem(
//       child: GestureDetector(
//         onTap: onTap,
//         child: ListTile(
//           leading: Icon(icon),
//           title: Text(purpose),
//         ),
//       ),
//     );
//   }
// }
