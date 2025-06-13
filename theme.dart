import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2E5BFF),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF9FAFB),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.5,
    iconTheme: const IconThemeData(color: Colors.black87),
    titleTextStyle: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  ),
  textTheme: GoogleFonts.interTextTheme().copyWith(
    bodyLarge: GoogleFonts.inter(fontSize: 16, color: Colors.black87),
    bodyMedium: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  useMaterial3: true,
);
