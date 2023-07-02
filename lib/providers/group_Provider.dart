import 'package:flutter/cupertino.dart';

class GroupProvider with ChangeNotifier {
  List<Map<String, dynamic>> myGroups = [
    {
      "groupName": "Programming In C",
      "numberOfAttendee": 47,
      "numberOfRecord": 15,
      "date": "jan 15,2022",
      "attendeeList": [
        {"name": "Chris Frome", "presentDays": 46},
        {"name": "Roglic", "presentDays": 33},
        {"name": "Tadej Pogacar", "presentDays": 17},
        {"name": "Graint Thomas", "presentDays": 22},
      ],
    },
    {
      "groupName": "Calculus-III",
      "numberOfAttendee": 37,
      "numberOfRecord": 22,
      "date": "March 30,2021",
      "attendeeList": [],
    },
    {
      "groupName": "Software Project Management",
      "numberOfAttendee": 33,
      "numberOfRecord": 32,
      "date": "Feb 15,2022",
      "attendeeList": [],
    },
    {
      "groupName": "Network Programming",
      "numberOfAttendee": 27,
      "numberOfRecord": 32,
      "date": "Dec 15,2022",
      "attendeeList": [],
    },
  ];
  GroupProvider();

  void addToList(String groupName) {
    myGroups.add({
      "groupName": groupName,
      "numberOfAttendee": 12,
      "numberOfRecord": 32,
      "date": "Feb 15,2022",
      "attendeeList": [],
    });
  }

  void addAttendeeToGroup(String fname, int index) {
    myGroups[index]["attendeeList"].add({
      "name": fname,
      "presentDays": 1,
    });
    notifyListeners();
  }

  void deleteFromList(String groupName) {
    for (int i = 0; i < myGroups.length; i++) {
      if (groupName == myGroups[i]["groupName"]) {
        myGroups.removeAt(i);
      }
    }
    notifyListeners();
  }

  void deleteAttendeeFromGroup(
      int groupIndex, int attendeeIndex, String attendeeName) {
    for (int i = 0; i < myGroups[groupIndex]["attendeeList"].length; i++) {
      if (attendeeName == myGroups[groupIndex]["attendeeList"][i]["name"]) {
        myGroups[groupIndex]["attendeeList"].removeAt(i);
      }
      // for(int j= 0; j< myGroups[groupIndex]["attendeeList"][i].length;)
    }
    notifyListeners();
  }
}

  // void addAttendeeToGroup(int groupIndex, Map<String, dynamic> attendee) {
  //   if (groupIndex >= 0 && groupIndex < myGroups.length) {
  //     myGroups[groupIndex]['attendeeList'].add(attendee);
  //     notifyListeners();
  //   }
  // }

