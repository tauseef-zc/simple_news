import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTheme {

  static MaterialColor primaryColor = Colors.orange;

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primarySwatch: primaryColor,
      textTheme: lightTextTheme,
      secondaryHeaderColor: Colors.grey.shade300,
      primaryColor: primaryColor,
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: primaryColor.shade500));

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: lightTextTheme,
      secondaryHeaderColor: Colors.black54,
      primaryColor: primaryColor,
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: primaryColor.shade500));

  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: primaryColor,
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