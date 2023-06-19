import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

import '../screens/manageAttendee.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  TextStyle drawerText =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white);
  Color drawerIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerbackgroundColor,
      // backgroundColor: Colors.grey[200],
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
              Icons.manage_accounts,
              color: drawerIconColor,
            ),
            title: Text('Manage Students', style: drawerText),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_outlined,
                  color: drawerIconColor,
                )),
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: drawerIconColor,
            ),
            title: Text('Home', style: drawerText),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_outlined,
                  color: drawerIconColor,
                )),
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.people_alt_outlined,
              color: drawerIconColor,
            ),
            title: Text(
              'Groups',
              style: drawerText,
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_outlined,
                  color: drawerIconColor,
                )),
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.library_books_outlined,
              color: drawerIconColor,
            ),
            title: Text('Report', style: drawerText),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_outlined,
                  color: drawerIconColor,
                )),
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.person_2,
              color: drawerIconColor,
            ),
            title: Text('Profile', style: drawerText),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_outlined,
                  color: drawerIconColor,
                )),
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
