import 'package:dating_china_app_mvp/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPalette {
  static const Color primary = Color(0xFFC8A1D2);
  static const Color secondary = Color.fromARGB(255, 255, 117, 140);
  static const Color background = Colors.white;
  static const Color textPrimary = Color(0xFF9B70B4);
  static const Color textBody = Colors.black87;
}

class AppTheme {
  static final ColorScheme _lightScheme = ColorScheme.fromSwatch().copyWith(
    primary: AppPalette.primary,
    secondary: AppPalette.secondary,
    background: AppPalette.background,
  );

  static final ColorScheme _darkScheme = const ColorScheme.dark(
    primary: AppPalette.primary,
    secondary: AppPalette.secondary,
  );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _lightScheme,
        primaryColor: AppPalette.primary,
        scaffoldBackgroundColor: AppPalette.background,
        textTheme: AppTypography.light,
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Colors.white,
            backgroundColor: AppPalette.primary,
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: _darkScheme,
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: AppTypography.dark,
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppPalette.textBody,
            backgroundColor: AppPalette.primary,
          )
        ),
      );
}
