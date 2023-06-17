import 'package:flutter/material.dart';
import 'package:presence/components/myGroup_tile.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

final List myGroupList = [
  ['Programming In C', 47, 'jan 15,2022', 10],
  ['Calculus-III', 30, 'march 30,2022', 10],
  ['Software Project Management', 20, 'feb 15,2022', 11],
  ['Network Programming', 47, 'jan 15,2022', 6],
  ['Data Mining', 37, 'june 15,2022', 10],
];

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 25)),
                Expanded(
                  child: Text(
                    'My Groups',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return MyGroupTile(
                    groupName: myGroupList[index][0],
                    numberOfAttendee: myGroupList[index][1],
                    numberOfRecords: myGroupList[index][3],
                    date: myGroupList[index][2]);
              },
              itemCount: myGroupList.length,
            ))
          ],
        ),
      ),
    ));
  }
}
