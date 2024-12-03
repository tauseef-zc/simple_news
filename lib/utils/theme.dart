import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      textTheme: lightTextTheme,
      secondaryHeaderColor: Colors.grey.shade300,
      primaryColor: Colors.orange,
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.orange.shade500));

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: lightTextTheme,
      secondaryHeaderColor: Colors.black54,
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.orange.shade500));

  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: Colors.orange,
        fontSize: 36,
        height: 0.9,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.inter(
          fontSize: 20,
          height: 1,
          fontWeight: FontWeight.w600));

  static TextStyle logoTitleOne = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 36,
  );

}