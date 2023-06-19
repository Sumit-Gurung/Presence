import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AttendeeProvider with ChangeNotifier {
  List<Map<String, dynamic>> attendeeName = [
    {"name": "Chris Frome", "presentDays": 46},
    {"name": "Roglic", "presentDays": 33},
    {"name": "Tadej Pogacar", "presentDays": 17},
    {"name": "Graint Thomas", "presentDays": 22},
  ];

  AttendeeProvider() {}

  void addToList(String fname) {
    attendeeName.add({
      "name": "$fname",
      "presentDays": 1,
    });
  }

  void deleteFromList(String fname) {
    for (int i = 0; i < attendeeName.length; i++) {
      if (fname == attendeeName[i]['name']) {
        attendeeName.removeAt(i);
      }
    }

    notifyListeners();
  }

  void editToList(String fname, String editFname) {
    for (int i = 0; i < attendeeName.length; i++) {
      if (fname == attendeeName[i]['name']) {
        attendeeName[i]['name'] == "${editFname}";
      }
    }
    // attendeeName.removeWhere((item) => item["name"] == "${fname}");
    notifyListeners();
  }
  // void editToList(String fname, String editFname) {
  //   for (int i = 0; i < fruitName.length; i++) {
  //     if (fname == fruitName[i]['name']) {
  //       fruitName[i]['name'] == "${editFname}";
  //     }
  //   }
  //   // fruitName.removeWhere((item) => item["name"] == "${fname}");
  //   notifyListeners();
  // }
}
// attendeeName = [
  //   {"name": "Chris Frome", "presentDays": 46},
  //   {"name": "Roglic", "presentDays": 33},
  //   {"name": "Tadej Pogacar", "presentDays": 17},
  //   {"name": "Graint Thomas", "presentDays": 22},
  // ];