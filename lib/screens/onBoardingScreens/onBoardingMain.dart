import 'package:flutter/material.dart';
import 'package:presence/components/custom_button.dart';

class OnBoradingMainPage extends StatefulWidget {
  const OnBoradingMainPage({super.key});

  @override
  State<OnBoradingMainPage> createState() => _OnBoradingMainPageState();
}

class _OnBoradingMainPageState extends State<OnBoradingMainPage> {
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
                  SizedBox(
                    height: 54,
                  ),
                  CustomButton(
                      height: 54,
                      width: 224,
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
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
                        ),
                        children: [
                          TextSpan(
                            text: 'LOGIN',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
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
              ))),
    );
  }
}
