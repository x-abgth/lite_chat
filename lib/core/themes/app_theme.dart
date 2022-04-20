import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Primary colors are mostly seen in apps design
// Accent Colors are mostly used in buttons

class AppTheme {
  // light theme colors
  static Color lightBackgroundColor = Color(0xFFF8F9FA);
  static Color lightTextColor = Color(0xFF242B2E);
  static Color lightSubTextColor = Color(0xFF5E5E5E);

  // dark theme colors
  static Color darkPrimaryBackgroundColor = Color(0xFF434343);
  static Color darkSecondaryBackgroundColor = Color(0xFF000000);
  static Color darkSurfaceColor = Colors.white;
  static Color darkSubTextColor = Color(0xFFB8B8B8);

  // Common Colors
  static Color primaryColor = Color(0xFF5D3FD3);
  static Color recieverMessageBubble = Color(0xFF242B2E);
  static Color buttonColor = Color(0xFF7F00FF);

  const AppTheme._();
  static final lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    primaryColorLight: buttonColor,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: lightBackgroundColor,
          secondary: lightBackgroundColor,
          tertiary: buttonColor,
        ),
    scaffoldBackgroundColor: lightBackgroundColor,
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
    ),
    appBarTheme: AppBarTheme()
        .copyWith(foregroundColor: Colors.white, backgroundColor: primaryColor),
    textTheme: TextTheme(
      headline1: TextStyle(color: lightTextColor),
      headline6: TextStyle(color: lightTextColor),
      bodyText1: TextStyle(color: lightTextColor),
      bodyText2: TextStyle(color: lightTextColor),
      caption: TextStyle(color: lightTextColor),
      subtitle1: TextStyle(color: lightSubTextColor),
      subtitle2: TextStyle(color: lightSubTextColor),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    primaryColorLight: Colors.white,
    buttonTheme: ButtonThemeData(buttonColor: buttonColor),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: darkPrimaryBackgroundColor,
          secondary: darkSecondaryBackgroundColor,
          tertiary: buttonColor,
        ),
    appBarTheme: AppBarTheme()
        .copyWith(foregroundColor: Colors.white, backgroundColor: primaryColor),
    textTheme: TextTheme(
      headline1: TextStyle(color: darkSurfaceColor),
      headline6: TextStyle(color: darkSurfaceColor),
      bodyText1: TextStyle(color: darkSurfaceColor),
      bodyText2: TextStyle(color: darkSurfaceColor),
      caption: TextStyle(color: darkSurfaceColor),
      subtitle1: TextStyle(color: darkSubTextColor),
      subtitle2: TextStyle(color: darkSubTextColor),
    ),
  );

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkSecondaryBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
