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

  static const Color mainGradientOne = Color.fromARGB(255, 21, 180, 66);
  static const Color mainGradientTwo = Color(0xff5A5BF3);
  static const Color iconColor = Colors.black;
}

class Endpoints {
  static const String forSignup = "http://10.0.2.2:8000/auth/register/";
  static const String forLogin = "";
  static const String forProfileImage = "";
}

Color unSelecteddrawerIconColor = Colors.grey.shade600;
Color SelecteddrawerIconColor = Colors.white;
