import 'package:flutter/material.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:presence/providers/user_provider.dart';
// import 'package:presence/screens/authn/login.dart';
import 'package:presence/start_page.dart';

import 'package:provider/provider.dart';

import 'providers/Individual_attendee_provider.dart';

// import 'screens/homescreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AttendeeProvider>(
          create: (context) => AttendeeProvider(),
        ),
        ChangeNotifierProvider<GroupProvider>(
          create: (context) => GroupProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider())
      ],
      child: OurApp(),
      // child: SignUpPage(),
    ),
  );
}

class OurApp extends StatelessWidget {
  const OurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Dangrek',

                // fontSizeDelta: 4,
                fontSizeFactor: 0.95,

                bodyColor: Colors.black,
                displayColor: Colors.grey[600],
              ),
        ),
        // theme: ThemeData.light().copyWith(
        //     textTheme: TextTheme(bodyText1: TextStyle(fontFamily: 'Dangrek'))),
        // theme: ThemeData.light().copyWith(
        //     textTheme:
        //         GoogleFonts.dangrekTextTheme((Theme.of(context).textTheme))),
        // home: OnBoardingController(),
        home: StartPage());
  }
}
