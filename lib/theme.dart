import 'package:flutter/material.dart';

class ExpertsTheme {
  static const navy = Color(0xFF031A2E);
  static const navy2 = Color(0xFF08243B);
  static const navy3 = Color(0xFF0E304D);
  static const gold = Color(0xFFD9AC43);
  static const softGold = Color(0xFFF3D57A);
  static const ivory = Color(0xFFF8F7F2);
  static const paper = Color(0xFFF4F5F7);
  static const ink = Color(0xFF102132);

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(primary: gold, secondary: softGold, surface: navy2),
      scaffoldBackgroundColor: navy,
      appBarTheme: const AppBarTheme(
        backgroundColor: navy, foregroundColor: Colors.white, centerTitle: true,
        elevation: 0, titleTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: const Color(0xFF102D47),
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIconColor: Colors.white70,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Color(0xFF294965))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: gold,width: 1.3)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFF7F8FA),
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      fontFamily: 'sans',
    );
  }
}
