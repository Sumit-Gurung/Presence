// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/components/cutomFormField.dart';
import 'package:presence/model/userDetail.dart';
import 'package:presence/providers/user_provider.dart';
import 'package:presence/screens/authn/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_button.dart';
import '../../start_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsureText = true;

  bool isValid = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static FocusNode userNameFocusNode = FocusNode();
  static FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //set email and password to defaults
    // _userNameController.text = 'sumitgur1169@gmail.com';
    // _passwordController.text = 'sumit123';
  }

  @override
  Widget build(BuildContext context) {
    final heightt = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: heightt,
        child: Stack(
          children: [
            Container(
              height: heightt / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: AppColors.authBasicColor,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.mainGradientOne,
                        AppColors.mainGradientTwo
                      ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(62),
                      bottomRight: Radius.circular(62))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/authLogo.png',
                        ),
                      ),
                      Text(
                        'Presencee',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'AI-Based Attendace App!',
                    style: TextStyle(
                        fontSize: 15,
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
                      height: heightt / 1.8,
                      margin: EdgeInsets.all(23),
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                          SizedBox(
                            height: 15,
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
                                      return "Enter Email";
                                    }
                                    return null;
                                    // if(value.trim().length < 10){
                                    //   return "enter";

                                    // }
                                  },
                                  label: 'Enter Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 32,
                                    color: AppColors.authBasicColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomFormField(
                                  textController: _passwordController,
                                  obscureText: obsureText,
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
                                    child: Icon(
                                      obsureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.authBasicColor,
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      isValid =
                                          _formKey.currentState!.validate();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 23,
                                ),
                                CustomButton(
                                    height: 54,
                                    width: 224,
                                    borderRadius: 20,
                                    isValidated: isValid,
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        print('Tapp ta vacha ');
                                        try {
                                          Map toSendSignUp = {
                                            "email": _userNameController.text,
                                            "password": _passwordController.text
                                          };
                                          print("yaha samma thik cha");
                                          String toSendAsStringSignUp =
                                              jsonEncode(toSendSignUp);
                                          var response = await http.post(
                                              Uri.parse(Endpoints.forLogin),
                                              headers: {
                                                "Content-Type":
                                                    "application/json"
                                              },
                                              body: toSendAsStringSignUp);
                                          var loginResponseInJson =
                                              jsonDecode(response.body);
                                          // print('sad');
                                          print(response.body);
                                          if (response.statusCode >= 200 &&
                                              response.statusCode < 300) {
                                            final user = UserDetails(
                                                name:
                                                    loginResponseInJson['user']
                                                        ["name"],
                                                email:
                                                    loginResponseInJson['user']
                                                        ["email"],
                                                imagePath: loginResponseInJson[
                                                                'user']
                                                            ["profilePic"] !=
                                                        null
                                                    ? Endpoints.url +
                                                        loginResponseInJson[
                                                                'user']
                                                            ["profilePic"]
                                                    : null,
                                                phoneNumber:
                                                    loginResponseInJson['user']
                                                        ["phoneNumber"]);
                                            final UserProviderVariable =
                                                Provider.of<UserProvider>(
                                                    context,
                                                    listen: false);
                                            // saving in shared preferences
                                            var inst = await SharedPreferences
                                                .getInstance();

                                            await inst.setString(
                                                "accessToken",
                                                loginResponseInJson['token']
                                                    ['access']);

                                            print("Access token set as: " +
                                                inst.getString("accessToken")!);

                                            UserProviderVariable.setUser(user);
                                            print('push huna parne ho');

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StartPage()));
                                            // print('push huna parne ho');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    content: Text(
                                                        '${loginResponseInJson["message"]}')));
                                          }
                                        } catch (e) {
                                          print(
                                              "--------Exception catched!---------");
                                          print(e);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    AppColors.authBasicColor,
                                                content: Text(
                                                  "LOGIN-UP FAILED!",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )));
                                      }
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
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
                                height: 45,
                                child: Image.asset(
                                  'assets/images/apple.png',
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                child: Image.asset(
                                  'assets/images/GoogleImage.png',
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(
                                height: 45,
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
                          'Don\'t Have An Account? ',
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
                                  builder: (context) => SignUpPage(),
                                ));
                          },
                          child: Text(
                            'SignUP',
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
