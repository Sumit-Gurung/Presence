import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../start_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsureText = true;
  bool isValid = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/darkThemeBackground.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 190,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter UserName";
                            }
                            return null;
                            // if(value.trim().length < 10){
                            //   return "enter";

                            // }
                          },
                          decoration: InputDecoration(
                              hintText: 'UserName',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: obsureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              isValid = _formKey.currentState!.validate();
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obsureText = !obsureText;
                                  });
                                },
                                child: Icon(obsureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                            height: 54,
                            width: 224,
                            borderRadius: 20,
                            isValidated: isValid,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StartPage()));
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: 138,
                        ),
                        Text(
                          "Login With",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/FacebookImage.png'),
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset('assets/images/GoogleImage.png'),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
