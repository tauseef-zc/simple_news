import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTheme {

  static MaterialColor primaryColor = Colors.orange;

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      textTheme: lightTextTheme,
      secondaryHeaderColor: Colors.grey.shade300,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Colors.grey.shade300,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
      cardTheme: CardTheme(
        color: Colors.grey.shade100,
        shadowColor: Colors.white,
        elevation: 0
      ),
      chipTheme: ChipThemeData(
        shape: StadiumBorder(
          side: BorderSide(color: NewsTheme.primaryColor.shade100),
        ),
        backgroundColor: NewsTheme.primaryColor.shade50,
        surfaceTintColor: NewsTheme.primaryColor.shade100,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor.shade500));

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      canvasColor: Colors.black45,
      scaffoldBackgroundColor: Colors.black45,
      textTheme: darkTextTheme,
      secondaryHeaderColor: Colors.black54,
      primaryColor: primaryColor,
      chipTheme: ChipThemeData(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.grey.shade900,
        surfaceTintColor: Colors.grey.shade800,
      ),
      cardTheme: CardTheme(
        color: Colors.grey.shade900,
        shadowColor: Colors.black45,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black45,
        surfaceTintColor: Colors.black45,
      ),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black38,
          surfaceTintColor: Colors.black38,
          indicatorColor: Colors.grey.shade300,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          shadowColor: Colors.black
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor.shade500));

  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: primaryColor,
        fontSize: 36,
        height: 0.9,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.inter(
          fontSize: 20, height: 1, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.inter(
          fontSize: 36, height: 1, fontWeight: FontWeight.w500),
      titleMedium: GoogleFonts.inter(
          fontSize: 20, height: 1, fontWeight: FontWeight.w400),
      bodyLarge: GoogleFonts.inter(
          fontSize: 14, height: 1.5, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(
        fontSize: 12,
        height: 1.5,
      ));

  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: primaryColor,
        fontSize: 36,
        height: 0.9,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.inter(
          fontSize: 20, height: 1, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.inter(
          fontSize: 36, height: 1, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.inter(
          fontSize: 20, height: 1, fontWeight: FontWeight.w400),
      bodyLarge: GoogleFonts.inter(
          fontSize: 14, height: 1.5, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(
        fontSize: 12,
        height: 1.5,
      ));

  static TextStyle logoTitleOne = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 36,
  );
}
