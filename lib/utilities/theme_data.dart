import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData kLightTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  backgroundColor: const Color(0xFFF7F7FE),
  textTheme: TextTheme(
    headline1: GoogleFonts.playfairDisplay(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF8E6200)
    ),
    headline2: GoogleFonts.playfairDisplay(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    headline3: GoogleFonts.roboto(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: GoogleFonts.roboto(
      color: const Color(0xFF8C8C8C),
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.nunitoSans(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF8E6200)
  ),
);

ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFB522),
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.playfairDisplay(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline2: GoogleFonts.playfairDisplay(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    headline3: GoogleFonts.roboto(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: GoogleFonts.roboto(
      color: const Color(0xFFC9C9C9),
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.nunitoSans(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFFFB522),
  ),
);