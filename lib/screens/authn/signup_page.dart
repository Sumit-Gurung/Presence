// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/cutomFormField.dart';
import 'package:presence/screens/authn/login.dart';

import '../../components/custom_button.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool obsureText = true;
  bool _isvalid = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  static FocusNode userNameFocusNode = FocusNode();
  static FocusNode passwordFocusNode = FocusNode();
  static FocusNode confirmPasswordFocusNode = FocusNode();

  static FocusNode emailFocusNode = FocusNode();
  static FocusNode phoneNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _userNameController.text = "Arjun Adhikari";
    _emailController.text = "arjunq21@gmail.com";
    _passwordController.text = "asdfasdf1";
    _confirmPasswordController.text = "asdfasdf1";
    _phoneNumberController.text = "9841234567";
  }

  @override
  Widget build(BuildContext context) {
    final heightt = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: heightt,
        child: Stack(
          children: [
            Container(
              height: heightt / 4.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.authBasicColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(62),
                      bottomRight: Radius.circular(62))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/GoogleImage.png',
                    ),
                  ),
                  Text(
                    'Presence',
                    style: TextStyle(
                        fontSize: 34,
                        // fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: heightt,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: heightt / 1.3,
                      margin: EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'SignUpp',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                // fontFamily: 'RobotoSlab',
                                fontSize: 23),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomFormField(
                                  textController: _userNameController,
                                  focusNode: userNameFocusNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter UserName";
                                    }

                                    return null;
                                    // if(value.trim().length < 10){
                                    //   return "enter";

                                    // }
                                  },
                                  label: 'Enter UserName',
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 32,
                                    color: AppColors.authBasicColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                CustomFormField(
                                  textController: _emailController,
                                  focusNode: emailFocusNode,
                                  validator: (value) {
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value!);
                                    if (value.isEmpty) {
                                      return "Enter Email";
                                    } else if (!emailValid) {
                                      return "Enter Valid Email";
                                    }
                                    return null;
                                  },
                                  label: 'Enter Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 32,
                                    color: AppColors.authBasicColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                CustomFormField(
                                  textController: _passwordController,
                                  focusNode: passwordFocusNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
                                  label: 'Enter Password',
                                  prefixIcon: Icon(
                                    Icons.security,
                                    color: AppColors.authBasicColor,
                                    size: 32,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsureText = !obsureText;
                                      });
                                    },
                                    child: Icon(obsureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                CustomFormField(
                                  textController: _confirmPasswordController,
                                  focusNode: confirmPasswordFocusNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "ReEnter Password";
                                    } else if (_passwordController.text !=
                                        value) {
                                      return "Password didn't Matched";
                                    }
                                    return null;
                                  },
                                  label: 'ReEnter Password',
                                  prefixIcon: Icon(
                                    Icons.security_sharp,
                                    color: AppColors.authBasicColor,
                                    size: 32,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsureText = !obsureText;
                                      });
                                    },
                                    child: Icon(obsureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                CustomFormField(
                                  textController: _phoneNumberController,
                                  focusNode: phoneNumberFocusNode,
                                  validator: (value) {
                                    bool phoneNumberValid = RegExp(
                                            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                        .hasMatch(value!);
                                    if (!phoneNumberValid) {
                                      return "Enter Valid PhoneNumber";
                                    }
                                    return null;
                                  },
                                  label: 'Enter PhoneNumber',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    size: 32,
                                    color: AppColors.authBasicColor,
                                  ),
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      _isvalid =
                                          _formKey.currentState!.validate();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                CustomButton(
                                    height: 40,
                                    width: 224,
                                    borderRadius: 20,
                                    isValidated: _isvalid,
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          Map toSendSignUp = {
                                            "name": _userNameController.text,
                                            "email": _emailController.text,
                                            "password":
                                                _passwordController.text,
                                            "password2":
                                                _confirmPasswordController.text,
                                            "phoneNumber":
                                                _phoneNumberController.text
                                          };
                                          String toSendAsStringSignUp =
                                              jsonEncode(toSendSignUp);
                                          print("Aaxa");
                                          var response = await http.post(
                                              Uri.parse(Endpoints.forSignup),
                                              headers: {
                                                "Content-Type":
                                                    "application/json"
                                              },
                                              body: toSendAsStringSignUp);

                                          print(response.body);
                                          print("sucess");
                                        } catch (e) {
                                          print(
                                              "--------Exception catched!---------");
                                          print(e);
                                        }
                                        print("sucessssss");

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("SIGN-UP FAILED!")));
                                      }
                                    },
                                    child: Text(
                                      "Sign-Up",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Divider(
                                  // height: 10,
                                  // color: Colors.black,
                                  thickness: 4,
                                ),
                              ),
                              Text('   OR   '),
                              Expanded(
                                child: Divider(
                                  thickness: 4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 50,
                                child: Image.asset(
                                  'assets/images/apple.png',
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Image.asset(
                                  'assets/images/GoogleImage.png',
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Image.asset(
                                  'assets/images/nike.png',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have An Account? ',
                          style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
