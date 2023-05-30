import 'package:flutter/material.dart';

class onBoarding2nd extends StatefulWidget {
  const onBoarding2nd({super.key});

  @override
  State<onBoarding2nd> createState() => _OnBoarding2ndState();
}

class _OnBoarding2ndState extends State<onBoarding2nd> {
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
                  SizedBox(
                    height: 54,
                  ),
                  Text(
                    'All the fun starts here!\n\n Wanna feel these happy vibes?\n\n Create an account and you’re all set to go',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ))),
    );
  }
}
