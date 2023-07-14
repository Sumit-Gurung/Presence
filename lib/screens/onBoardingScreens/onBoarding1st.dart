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
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    width: 310,
                    child: Image.asset(
                      'assets/images/onBoarding1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 35,
            ),
            Text('Create Groups',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFFFF4E4A),
                    fontWeight: FontWeight.w600)),
            // SizedBox(
            //   height: ,
            // ),
            Text(
                'Begin by creating your own group and harness the power of AI.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      )),
    );
  }
}
