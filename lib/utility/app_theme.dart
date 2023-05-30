import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData get darktheme {
    return ThemeData.dark().copyWith(
      textTheme: GoogleFonts.robotoTextTheme().apply(bodyColor: Colors.white),
    );
  }
}
