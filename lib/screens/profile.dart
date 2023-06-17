import 'package:flutter/material.dart';

import '../utility/gradient_border.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? selectedTileIndex;
  void handleTileTap(int index) {
    setState(() {
      selectedTileIndex = index;
      // index == 0
      //     ? Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ,
      //         ))
      //     : (index == 3)
      //         ? Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => GenerateId()))
      //         : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 25)),
                SizedBox(height: 20),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      'Name Guurng',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      '+977 9812345678',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 35),
                    // GradientBorder(
                    //   radius: 15,
                    //   height: 52,
                    //   width: 213,
                    //   child: RichText(
                    //       text: TextSpan(
                    //           text: '5th Sem ',
                    //           style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w400,
                    //               color: Colors.black),
                    //           children: [
                    //         WidgetSpan(
                    //             child: SizedBox(
                    //           width: 8,
                    //         )),
                    //         TextSpan(
                    //             text: 'Student',
                    //             style: TextStyle(
                    //                 fontSize: 24,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.black))
                    //       ])),
                    // ),
                    SizedBox(height: 15),
                    CustomListTile(
                      onTap: () => handleTileTap(0),
                      isSelected: selectedTileIndex == 0,
                      icon: Icons.home,
                      title: 'Account',
                      subtitle: 'View your personal info',
                    ),
                  ],
                ),
                CustomListTile(
                    isSelected: selectedTileIndex == 1,
                    onTap: () => handleTileTap(1),
                    icon: Icons.my_library_books_rounded,
                    title: 'My Reports',
                    subtitle: 'See Your Progress'),
                CustomListTile(
                    isSelected: selectedTileIndex == 2,
                    onTap: () => handleTileTap(2),
                    // onLongPress: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => MyDevices()));
                    // },
                    icon: Icons.groups,
                    title: 'My Groups',
                    subtitle: ' Manage your Groups and More'),
                CustomListTile(
                    isSelected: selectedTileIndex == 3,
                    onTap: () => handleTileTap(3),
                    icon: Icons.add_card,
                    title: 'Generate ID Card',
                    subtitle: ' Generate Id card and QR code'),
                CustomListTile(
                    isSelected: selectedTileIndex == 4,
                    onTap: () => handleTileTap(4),
                    icon: Icons.settings,
                    title: 'Settings',
                    subtitle: 'Manage Settings'),
                CustomListTile(
                    isSelected: selectedTileIndex == 5,
                    onTap: () => handleTileTap(5),
                    icon: Icons.logout,
                    title: 'Logout',
                    subtitle: ' Signout from this deveice')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CustomListTile({
    required this.isSelected,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? null : Colors.grey[200],
            gradient: isSelected
                ? (LinearGradient(
                    colors: [Color(0xff65F4CD), Color(0xff5A5BF3)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ))
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 22),
            Icon(
              icon,
              size: 25,
            ),
            SizedBox(width: 36),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 2),
                Text(subtitle,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
