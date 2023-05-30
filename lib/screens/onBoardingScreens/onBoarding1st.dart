import 'package:flutter/material.dart';

class OnBoarding1st extends StatefulWidget {
  const OnBoarding1st({super.key});

  @override
  State<OnBoarding1st> createState() => _OnBoarding1stState();
}

class _OnBoarding1stState extends State<OnBoarding1st> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/onboarding_screen.png'),
                      fit: BoxFit.fill)),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 142,
                  ),
                  Text('WELCOME',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 26,
                  ),
                  Text('ON BOARD',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w400)),
                ],
              ))),
    );
  }
}
