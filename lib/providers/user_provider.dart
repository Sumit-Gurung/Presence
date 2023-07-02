import 'package:flutter/cupertino.dart';

import 'package:presence/model/userDetail.dart';

class UserProvider with ChangeNotifier {
  UserDetails? _user;
  UserDetails? get user => _user;

  void setUser(UserDetails user) {
    _user = user;
    notifyListeners();
  }
}
