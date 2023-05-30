import 'package:flutter/material.dart';
import 'package:presence/screens/groups.dart';
import 'package:presence/screens/homescreen.dart';
import 'package:presence/screens/profile.dart';
import 'package:presence/screens/report.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selectedIndex = 0;
  // final _selectedBgColor = Color.fromRGBO(255, 255, 255, 0.14);
  // final _unselectedBgColor = Colors.black;
  // Color _getBgColor(int index) =>
  //     _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  static const List pages = [
    HomeScreen(),
    Groups(),
    Report(),
    Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  mycolumn(String asset, String text, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        color: (selectedIndex == index)
            ? Color.fromRGBO(255, 255, 255, 0.5)
            : Color.fromRGBO(255, 255, 255, 0.14),
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, height: 28, width: 28),
            Text(text,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            mycolumn('assets/images/home.png', 'Home', 0),
            mycolumn('assets/images/freelancer.png', 'Freelancer', 1),
            mycolumn('assets/images/company.png', 'Company', 2),
            mycolumn('assets/images/History.png', 'History', 3),
          ],
        ),
      ),
    );
  }
}
