import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
          //padding: EdgeInsets.symmetric(horizontal: 40),
          // width: 300,
          height: 37,
          padding: EdgeInsets.only(left: 9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 18,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.black26,
                )),
          ),
        ),
      ),
    ]);
  }
}
