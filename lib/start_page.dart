import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
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
    ProfilePage(),
  ];
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
        color: (selectedIndex == index)
            ? Color.fromRGBO(255, 255, 255, 0.5)
            : null,
        width: MediaQuery.of(context).size.width / 4,
        child: Padding(
          padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (selectedIndex == index)
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.mainGradientOne,
                            AppColors.mainGradientTwo,
                          ],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        bottomNavIcon,
                        size: 28,
                      ),
                    )
                  : Icon(
                      bottomNavIcon,
                      size: 28,
                    ),

              // Image.asset(asset, height: 28, width: 28),
              Text(text,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400))
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/GoogleImage.png',
          fit: BoxFit.fill,
        ),
        backgroundColor: Color.fromARGB(255, 55, 117, 171),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 70, 116, 156),
        // backgroundColor: Colors.grey[200],
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 55,
                    ),
                    Text(
                      'Name Gurung',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Groups',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.library_books_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Report',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.person_2,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 2,
            ),
          ],
        ),
      ),

      body: pages[selectedIndex],
      floatingActionButton: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainGradientOne,
              AppColors.mainGradientTwo,
            ],
          ).createShader(bounds);
        },
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.camera_enhance_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 55, 117, 171),
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
