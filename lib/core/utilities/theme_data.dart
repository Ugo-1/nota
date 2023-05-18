import 'package:flutter/material.dart';
import 'package:nota/core/utilities/app_colors.dart';
import 'package:nota/core/utilities/fonts.dart';

ThemeData kLightTheme = ThemeData(
  useMaterial3: true,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF8E6200),
    ),
    displayMedium: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    displaySmall: TextStyle(
      fontFamily: Fonts.roboto,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: Fonts.roboto,
      color: const Color(0xFF8C8C8C),
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: Fonts.nunitoSans,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF8E6200),
  ),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF7F7FE),
  ),
  extensions: <ThemeExtension<dynamic>>[
    AppColors(
      whiteSandColor: const Color(0xFFF6F6F6),
      barleyWhiteColor: const Color(0xFFFFF3CC),
      hawkesBlueColor: const Color(0xFFD9E8FD),
      peachSchnappsColor: const Color(0xFFFFD7D3),
      polarColor: const Color(0xFFDCF5F8),
      snuffColor: const Color(0xFFDBDCF1),
      linkWaterColor: const Color(0xFFE0E7F5),
    ),
  ],
);

ThemeData kDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFB522),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: Fonts.playfairDisplay,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    displaySmall: TextStyle(
      fontFamily: Fonts.roboto,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontFamily: Fonts.roboto,
      color: const Color(0xFFC9C9C9),
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: Fonts.nunitoSans,
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
  extensions: <ThemeExtension<dynamic>>[
    AppColors(
      whiteSandColor: const Color(0xFF6F6F6F),
      barleyWhiteColor: const Color(0xFF4E3F10),
      hawkesBlueColor: const Color(0xFF353546),
      peachSchnappsColor: const Color(0xFFEB4D3D),
      polarColor: const Color(0xFF114D33),
      snuffColor: const Color(0xFF124349),
      linkWaterColor: const Color(0xFF374052),
    ),
  ],
);
