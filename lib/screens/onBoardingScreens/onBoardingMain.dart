import 'package:flutter/material.dart';
import 'package:presence/components/custom_button.dart';
import 'package:presence/screens/authn/login.dart';

import '../authn/signup_page.dart';

class OnBoradingMainPage extends StatefulWidget {
  const OnBoradingMainPage({super.key});

  @override
  State<OnBoradingMainPage> createState() => _OnBoradingMainPageState();
}

class _OnBoradingMainPageState extends State<OnBoradingMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          padding: EdgeInsets.all(24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              // Text('WELCOMEE',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 48,
              //       fontWeight: FontWeight.w600,
              //     )),
              // SizedBox(
              //   height: 15,
              // ),
              // Text('ON BOARD',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 36,
              //       fontWeight: FontWeight.w400,
              //     )),
              // SizedBox(
              //   height: 45,
              // ),
              SizedBox(
                height: 350,
                width: 350,
                child: Image.asset('assets/images/onBoardingLogo.png',
                    fit: BoxFit.fill),
              ),
              Text(
                'Welcome OnBoard!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                  height: 54,
                  width: 224,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              SizedBox(
                height: 37,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Have an Account? Cool!\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontFamily: 'Dangrek'),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            // Handle the tap gesture here
                            // For example, navigate to the login screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            'LOGINN',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.grey[800],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ' then!',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
