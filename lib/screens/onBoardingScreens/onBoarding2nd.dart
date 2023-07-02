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
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add Attendee',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.w600)),
                      Text(
                          'Group banapache attendee haru add garnu parcha lah! ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ],
            ),

            // SizedBox(
            //   height: ,
            // ),

            SizedBox(
              height: 35,
            ),

            Container(
              height: 350,
              width: 310,
              child: Image(image: AssetImage('assets/images/onBoarding2.png')),
            ),
          ],
        ),
      )),
    );
  }
}
