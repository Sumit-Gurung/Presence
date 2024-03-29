import 'dart:io';

import 'package:flutter/material.dart';

class AppColors {
  // static const Color primaryColor = Color(0xFF00ADEF);
  // static const Color secondaryColor = Color(0xFFE64C66);
  static Color backgroundColor = Colors.grey.shade300;
  static Color tilebackgroundColor = Colors.grey.shade200;
  static Color drawerbackgroundColor = Color.fromARGB(255, 246, 241, 241);
  static Color tileBorderColor = Colors.white;
  static Color authBasicColor = Color.fromARGB(255, 4, 133, 155);
  static Color authFocusedBorderColor = Colors.green;

  static const Color mainGradientOne = Color.fromARGB(255, 48, 201, 243);

  static const Color mainGradientTwo = Color(0xff004A57);

  static const Color iconColor = Colors.black;
}

class Endpoints {
  static get url =>
      //  'http://192.168.1.3:8000';
      Platform.isAndroid ? "http://10.0.2.2:8000" : "http://localhost:8000";

  static String forSignup = "$url/auth/register/";
  static String forLogin = "$url/auth/login/";
  static String forProfileImage = "$url/auth/profilePic/";
  static String forAllUsers = "$url/auth/allUsers/";
  static String forCreateGroup = "$url/group/create/";
  static String forShowMyGroups = "$url/group/groups/";
  static String forDeleteGroup = "$url/group/delete/";
  static String forAddingOrRemovingAttendeeToGroup = "$url/group/attendees/";
  static String forShowingAttendeeOfGroup = "$url/group/attendeesOfGroup/";
  static String forRecommendationOfGroup = "$url/group/recomendation/";
  static String forTakingAttendance = "$url/attendance/takeAttendance/";
  static String forUpdatingAttendance = "$url/attendance/updateAttendance/";
  static String forShowingEnrolledGroups = "$url/group/involvement";
  static String forEnrolledGroupsReport = "$url/attendance/reports/my/";
  static String forMyGroupsReport = "$url/attendance/reports/myGroups/";
  static String forUploadPhotoForAttendance = "$url/capture/photo/";
  static String forUpdatingGroupName = "$url/group/update/";
  static String forSendNotification = "$url/alert/sendnotification/";
  static String forGetNotification = "$url/alert/getnotification/";
  static String forAcckNotification = "$url/alert/accknotification/";

}

Color unSelecteddrawerIconColor = Colors.grey.shade600;
Color SelecteddrawerIconColor = Colors.white;
