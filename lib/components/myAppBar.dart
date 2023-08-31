import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presence/screens/notificationScreen.dart';
import 'package:presence/start_page.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  // final int?
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      leading: Container(
        margin: EdgeInsets.only(left: 15),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              size: 30,
            )),
      ),
      centerTitle: true,
      title: Text(
        title,
      ),
      titleTextStyle: GoogleFonts.dangrek(
          textStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      // TextStyle(
      //     color: Colors.black,

      //     fontSize: 24,
      //     fontWeight: FontWeight.bold),

      backgroundColor: Colors.grey[200],
      // elevation: ,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ));
            },
            icon: Icon(
              Icons.notifications,
            )),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartPage(
                      selectedIndexFromOutside: 3,
                    ),
                  ));
            },
            icon: Icon(
              Icons.person,
            )),
      ],
    );
  }
}
