import 'package:flutter/cupertino.dart';

class GroupProvider with ChangeNotifier {
  List<Map<String, dynamic>> myGroups = [
    {
      "groupName": "Programming In C",
      "numberOfAttendee": 47,
      "numberOfRecord": 15,
      "date": "jan 15,2022",
      "attendeeList": [],
    },
    {
      "groupName": "Calculus-III",
      "numberOfAttendee": 37,
      "numberOfRecord": 22,
      "date": "March 30,2021"
    },
    {
      "groupName": "Software Project Management",
      "numberOfAttendee": 33,
      "numberOfRecord": 32,
      "date": "Feb 15,2022"
    },
    {
      "groupName": "Network Programming",
      "numberOfAttendee": 27,
      "numberOfRecord": 32,
      "date": "Dec 15,2022"
    },
  ];
  GroupProvider() {}

  void addToList(String groupName) {
    myGroups.add({
      "groupName": "$groupName",
      "numberOfAttendee": 12,
      "numberOfRecord": 32,
      "date": "Feb 15,2022",
      "attendeeList": [],
    });
  }

  void deleteFromList(String groupName) {
    for (int i = 0; i < myGroups.length; i++) {
      if (groupName == myGroups[i]["groupName"]) {
        myGroups.removeAt(i);
      }
    }
    notifyListeners();
  }

  void addAttendeeToGroup(int groupIndex, Map<String, dynamic> attendee) {
    if (groupIndex >= 0 && groupIndex < myGroups.length) {
      myGroups[groupIndex]['attendeeList'].add(attendee);
      notifyListeners();
    }
  }
}
