import 'package:flutter/material.dart';

// Define the primary colors and gradients
class AppTheme {
  static const Color colorMenu = Color(0xFF515172);
  static const Color colorMenuActive = Color(0xFF8181B1);
  static const Color colorWhite = Colors.white;
  static const Color textColor = Colors.white;
  static const Color bodyBg = Color(0xFF1E1E2B);
  static const Color colorPurplePrimary = Color(0xFFC7A0FD);
  static const Color colorPrimary = Color(0xFF9E71FF);
  static const Color colorSecondary = Color(0xFF16CEF6);
  static const double buttonHeight = 64;
  static const Color tapRing1Color = Color(0x9088d912);
  static const Color tapRing2Color = Color(0x90cdff83);
  static const Color tapRing3Color = Color(0x90f5ffe7);

  // Define gradients
  static const Gradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colorPrimary,
      colorSecondary,
    ],
  );

  static const Gradient gradientSecondary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colorPrimary,
      Color(0xFFFF7999),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: colorPrimary,
    scaffoldBackgroundColor: bodyBg,
    buttonTheme: ButtonThemeData(
      height: buttonHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      buttonColor: colorPrimary,
    ),
    cardTheme: CardTheme(
      color: colorMenu,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
