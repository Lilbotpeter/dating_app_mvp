import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ColorScheme _lightScheme = ColorScheme.fromSeed(seedColor: Colors.indigoAccent);
  static final ColorScheme _darkScheme = ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark); 
  
  static ThemeData get light => ThemeData(
    colorScheme: _lightScheme,
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(shape: const StadiumBorder())),
  );

  static ThemeData get dark => ThemeData(
    colorScheme: _darkScheme,
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
  );
}