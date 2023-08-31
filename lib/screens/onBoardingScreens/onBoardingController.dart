import 'package:flutter/material.dart';
import 'package:presence/screens/authn/login.dart';
// import 'package:presence/start_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onBoarding1st.dart';
import 'onBoarding2nd.dart';
import 'onBoarding3rd.dart';
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
        alignment: AlignmentDirectional.topStart,
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                lastPage = (value == 3);
              });
            },
            controller: _pageController,
            children: const [
              OnBoarding1st(),
              onBoarding2nd(),
              onBoarding3rd(),
              OnBoradingMainPage()
            ],
          ),
          Container(
            alignment: Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(3);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.grey[700]),
                    )),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey.shade800,
                      dotWidth: 15,
                      activeDotColor: Colors.grey.shade700),
                ),
                lastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text('Done',
                            style: TextStyle(color: Colors.grey[700])))
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.bounceIn);
                        },
                        child: Text('Next',
                            style: TextStyle(color: Colors.grey[700])))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
