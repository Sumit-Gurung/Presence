import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/screens/cameraScreen.dart';
// import 'package:presence/screens/cameraScreen.dart';
import 'package:presence/screens/groupScreen.dart';
import 'package:presence/screens/homescreen.dart';
import 'package:presence/screens/notificationScreen.dart';
import 'package:presence/screens/profile.dart';
import 'package:presence/screens/report.dart';
// import 'package:presence/screens/testallgroups.dart';
import 'package:presence/utility/mydrawer.dart';

class StartPage extends StatefulWidget {
  final bool? showprofile;
  final int? selectedIndexFromOutside;

  const StartPage({super.key, this.showprofile, this.selectedIndexFromOutside});

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
    ProfilePage(),
  ];
  //   if (widget.selectedIndexFromOutside != null) {
  //     selectedIndex = widget.selectedIndexFromOutside!;
  //   }
  //  selectedIndex = widget.selectedIndexFromOutside ?? index;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  mycolumn(
    IconData bottomNavIcon,
    String text,
    int index,
    double leftPadding,
    double rightPadding,
  ) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        // color: (selectedIndex == index) ? Colors.grey[400] : null,
        width: MediaQuery.of(context).size.width / 4,
        child: Padding(
          padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (selectedIndex == index)
                  ?
                  // ? ShaderMask(
                  //     shaderCallback: (Rect bounds) {
                  //       return LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: const [
                  //           AppColors.mainGradientOne,
                  //           AppColors.mainGradientTwo,
                  //         ],
                  //       ).createShader(bounds);
                  //     },
                  //     child:
                  Icon(
                      bottomNavIcon,
                      size: 28,
                      color: AppColors.authBasicColor,
                    )
                  : Icon(
                      bottomNavIcon,
                      size: 28,
                    ),

              // Image.asset(asset, height: 28, width: 28),
              Text(text,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: (selectedIndex == index)
                          ? AppColors.authBasicColor
                          : Colors.grey[600]))
            ],
          ),
        ),
      ),
    );
  }

  // List<Color> _getGradientColors() {
  //   final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  //   return isDarkTheme
  //       ? [
  //           AppColors.mainGradientOne,
  //           AppColors.mainGradientTwo,
  //         ]
  //       : [
  //           Colors.black,
  //           Colors.black,
  //         ];
  // }
  @override
  void initState() {
    super.initState();
    if (widget.selectedIndexFromOutside != null) {
      selectedIndex = widget.selectedIndexFromOutside!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 185,
            width: 250,
            child: Image.asset(
              'assets/images/PresenceMain.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // backgroundColor: Color.fromARGB(255, 55, 117, 171),
        backgroundColor: Colors.grey[200],
        // elevation: ,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NotificationScreen();
                  },
                ));
              },
              icon: Icon(
                Icons.notifications,
              )),
          IconButton(
              onPressed: () {
                _onItemTapped(3);
              },
              icon: Icon(
                Icons.person,
              )),
        ],
      ),
      drawer: MyDrawer(),

      body: pages[selectedIndex],
      floatingActionButton: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color.fromARGB(255, 135, 223, 116),
              Color.fromARGB(255, 112, 154, 182),
            ],
          ).createShader(bounds);
        },
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(),
                ));
          },
          child: Icon(
            Icons.camera_enhance_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // color: Color.fromARGB(255, 55, 117, 171),
        color: Colors.grey[200],

        //
        notchMargin: 10,
        // padding: EdgeInsets.all(5),
        shape: CircularNotchedRectangle(),
        height: 55,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              mycolumn(Icons.home, 'Hoooome', 0, 0, 0),
              mycolumn(Icons.people_alt_outlined, 'Group', 1, 0, 20),
              mycolumn(Icons.book_online_outlined, 'Report', 2, 20, 0),
              mycolumn(Icons.person_2_outlined, 'Profile', 3, 0, 0),
            ]),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 60,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       mycolumn('assets/images/home.png', 'Home', 0),
      //       mycolumn('assets/images/freelancer.png', 'Freelancer', 1),
      //       mycolumn('assets/images/company.png', 'Company', 2),
      //       mycolumn('assets/images/History.png', 'History', 3),
      //     ],
      //   ),
      // ),
    );
  }
}
