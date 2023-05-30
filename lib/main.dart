import 'package:flutter/material.dart';
import 'package:presence/screens/onBoardingScreens/onBoardingController.dart';

import 'screens/homescreen.dart';

void main() {
  runApp(OurApp());
}

class OurApp extends StatelessWidget {
  const OurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: OnBoardingController());
  }
}
