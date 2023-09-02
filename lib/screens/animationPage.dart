import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ShowAnimation extends StatelessWidget {
  const ShowAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 500,
              width: 380,
              child: Lottie.asset('assets/animations/photoProcess.json'),
            ),
          ),
          SizedBox(
            height: 00,
          ),
          Center(
            child: Container(
                height: 200,
                width: 200,
                child: Lottie.asset('assets/animations/linearLoading.json')),
          )
        ],
      )),
    );
  }
}
