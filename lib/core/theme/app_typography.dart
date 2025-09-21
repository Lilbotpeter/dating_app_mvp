import 'package:dating_china_app_mvp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography._();
  //Light Theme
  static TextTheme light = GoogleFonts.promptTextTheme().copyWith(
    headlineLarge: GoogleFonts.k2d(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppPalette.textPrimary,
    ),
    headlineMedium: GoogleFonts.k2d(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppPalette.textPrimary,
    ),
    titleMedium: GoogleFonts.prompt(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppPalette.textBody,
    ),
    bodyLarge: GoogleFonts.prompt(
      fontSize: 16,
      color: AppPalette.textBody,
    ),
    bodyMedium: GoogleFonts.prompt(
      fontSize: 14,
      color: AppPalette.textBody,
    ),
    labelLarge: GoogleFonts.prompt(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  //Dark Theme
  static TextTheme dark = GoogleFonts.promptTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme,
  ).copyWith(
    headlineLarge: GoogleFonts.k2d(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.k2d(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    titleMedium: GoogleFonts.prompt(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    bodyLarge: GoogleFonts.prompt(
      fontSize: 16,
      color: Colors.white70,
    ),
    bodyMedium: GoogleFonts.prompt(
      fontSize: 14,
      color: Colors.white60,
    ),
    labelLarge: GoogleFonts.prompt(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

}