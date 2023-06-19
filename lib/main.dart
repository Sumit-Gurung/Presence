import 'package:flutter/material.dart';
import 'package:presence/providers/group_Provider.dart';
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
      ],
      child: OurApp(),
    ),
  );
}

class OurApp extends StatelessWidget {
  const OurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: StartPage());
  }
}
