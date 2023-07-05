// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

class NotificationScreen extends StatelessWidget {
  final List NotificationList = [
    ["New Message", 'You have a new message from John Doe.', '10:30 AM'],
    [
      'New Message',
      'Don\'t forget to attend the meeting at 2:00 PM.',
      '11:45 AM'
    ],
    ['Event Invitation', 'You are invited to a party on Saturday.', '1:15 PM']
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Notifications'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[200],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: NotificationList.length,
                itemBuilder: (context, index) {
                  return NotificationItem(
                      title: NotificationList[index][0],
                      subtitle: NotificationList[index][1],
                      time: NotificationList[index][2]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.tilebackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ],
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(height: 1.3),
        ),
        trailing: Text(
          time,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
