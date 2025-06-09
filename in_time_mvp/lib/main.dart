import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_time_mvp/screens/get_started.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 15, 63, 12),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: GoogleFonts.manropeTextTheme(ThemeData().textTheme).copyWith(
          titleLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      home: GetStartedScreen(),
    ),
  );
}
