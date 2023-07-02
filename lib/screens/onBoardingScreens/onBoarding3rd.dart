import 'package:flutter/material.dart';

class onBoarding3rd extends StatefulWidget {
  const onBoarding3rd({super.key});

  @override
  State<onBoarding3rd> createState() => _onBoarding3rdState();
}

class _onBoarding3rdState extends State<onBoarding3rd> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 350,
                  width: 310,
                  child: Image.asset(
                    'assets/images/onBoarding3.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 35,
            ),
            Text('Take Photo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    color: Color.fromARGB(255, 3, 86, 229),
                    fontWeight: FontWeight.w600)),
            // SizedBox(
            //   height: ,
            // ),
            Text('Photo soto kechne ane voilaaa attendance huncha! ',
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
