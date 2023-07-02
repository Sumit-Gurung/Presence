import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/start_page.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int selectedIndex = 0;

  void onSelectt(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerbackgroundColor,
      // backgroundColor: Colors.grey[200],
      child: ListView(
        // shrinkWrap: true,
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
                decoration: BoxDecoration(color: AppColors.authBasicColor),
                padding: EdgeInsets.only(top: 15, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 55,
                    ),
                    SizedBox(
                      // height: 200,
                      child: Text(
                        'Name Gurung',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )
                  ],
                )),
          ),

          // Divider(
          //   color: Colors.grey[800],
          //   thickness: 2,
          // ),
          DrawerTile(
              title: 'Home',
              onTap: () {
                onSelectt(0);
              },
              isSelected: selectedIndex == 0,
              navigateIndex: 0,
              iconData: Icons.home),
          DrawerTile(
              title: 'Groups',
              onTap: () {
                onSelectt(1);
              },
              isSelected: selectedIndex == 1,
              navigateIndex: 1,
              iconData: Icons.group),

          DrawerTile(
              title: 'Reports',
              onTap: () {
                onSelectt(2);
              },
              isSelected: selectedIndex == 2,
              navigateIndex: 2,
              iconData: Icons.note_alt),
          DrawerTile(
              title: 'Profile',
              onTap: () {
                onSelectt(3);
              },
              isSelected: selectedIndex == 3,
              navigateIndex: 3,
              iconData: Icons.person),
        ],
      ),
    );
  }
}

class DrawerTile extends StatefulWidget {
  final String title;
  final int navigateIndex;
  final IconData iconData;

  final bool isSelected;

  final VoidCallback onTap;

  const DrawerTile(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.navigateIndex,
      required this.onTap,
      required this.iconData});

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  // const DrawerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // margin: EdgeInsets.only(bottom: 10),
        // constraints: BoxConstraints.,
        color: widget.isSelected ? AppColors.authBasicColor : Colors.white,
        child: ListTile(
          leading: Icon(
            widget.iconData,
            color: widget.isSelected
                ? SelecteddrawerIconColor
                : unSelecteddrawerIconColor,
          ),
          title: Text(widget.title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color:
                      widget.isSelected ? Colors.white : Colors.grey.shade700)),
          trailing: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartPage(
                        selectedIndexFromOutside: widget.navigateIndex,
                      ),
                    ));
              },
              icon: Icon(
                Icons.arrow_forward_outlined,
                color: widget.isSelected
                    ? SelecteddrawerIconColor
                    : unSelecteddrawerIconColor,
              )),
        ),
      ),
    );
  }
}
