import 'package:flutter/material.dart';
import 'package:presence/screens/homescreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onBoarding1st.dart';
import 'onBoarding2nd.dart';
import 'onBoardingMain.dart';

class OnBoardingController extends StatefulWidget {
  const OnBoardingController({super.key});

  @override
  State<OnBoardingController> createState() => _OnBoardingControllerState();
}

class _OnBoardingControllerState extends State<OnBoardingController> {
  final _pageController = PageController();
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                lastPage = (value == 2);
              });
            },
            controller: _pageController,
            children: const [OnBoarding1st(), onBoarding2nd(), OnBoradingMainPage()],
          ),
          Container(
            alignment: Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(2);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    )),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey.shade800,
                      dotWidth: 15,
                      activeDotColor: Colors.green.shade400),
                ),
                lastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child:
                            Text('Done', style: TextStyle(color: Colors.white)))
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.bounceIn);
                        },
                        child:
                            Text('Next', style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
