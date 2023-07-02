import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presence/utility/individual_attendance_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    // margin: EdgeInsets.only(left: 25),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset('assets/images/preferences.png'),
                  ),
                  Text(
                    'Detected Peoples(9)',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Dangrek',
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Present??',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Individual_tile();
                    }),
              )
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 25.0),
              //   child: ListView.builder(itemBuilder: (context, index) {
              //     return Individual_tile();
              //   }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
