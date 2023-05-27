import 'package:flutter/material.dart';

class LightTheme {
  static const Color secondaryColor = Color(0xFF195c6e);

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // Text Themes
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Input Field
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey.shade800,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Button Themes

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(secondaryColor),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(18),
        ),
        // shape: MaterialStateProperty.all(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        // ),
        // textStyle: MaterialStateProperty.all<TextStyle>(
        //   const TextStyle(
        //     fontWeight: FontWeight.bold,
      ),
    ),
  );
}
