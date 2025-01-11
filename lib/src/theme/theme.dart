import 'package:actify/src/constants/colors.dart';
import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
  primaryColor: lightColorScheme.primary,
  primaryColorDark: const Color(0xFF013463),
  primaryColorLight: const Color(0xFF93adc4),
  colorScheme: lightColorScheme,
  unselectedWidgetColor: Colors.grey,

  scaffoldBackgroundColor: lightColorScheme.background,
  dividerColor: Colors.grey[400],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
      MaterialStateProperty.all<Color>(lightColorScheme.primary),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),

  appBarTheme: AppBarTheme(backgroundColor: primaryColor,titleTextStyle: TextStyle(color: lightColorScheme.onPrimary,fontSize: 20),iconTheme: IconThemeData(color: Colors.white)),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.black,
    splashFactory: NoSplash.splashFactory,
    unselectedLabelColor: Colors.black,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 2, color: lightColorScheme.primary))),
  ),
  radioTheme: RadioThemeData(
    fillColor:
    MaterialStateColor.resolveWith((states) => lightColorScheme.primary),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.black54),
  ),
  textTheme: TextTheme(
      displaySmall: TextStyle(
          fontSize: TextSize.small,
          fontWeight: FontWeight.w500,
          color: lightColorScheme.onSecondary),
      displayMedium: TextStyle(
          fontSize: TextSize.medium,
          fontWeight: FontWeight.w500,
          color: lightColorScheme.onSecondary),
      displayLarge: TextStyle(
          fontSize: TextSize.large,
          fontWeight: FontWeight.w500,
          color: lightColorScheme.onSecondary),
      headlineSmall: TextStyle(
          fontSize: TextSize.small,
          fontWeight: FontWeight.bold,
          color: lightColorScheme.secondary),
      headlineMedium: TextStyle(
          fontSize: TextSize.medium,
          fontWeight: FontWeight.bold,
          color: lightColorScheme.secondary),
      headlineLarge: TextStyle(
          fontSize: TextSize.large,
          fontWeight: FontWeight.bold,
          color: lightColorScheme.secondary),
      titleSmall: TextStyle(
          fontSize: TextSize.small,
          fontWeight: FontWeight.w500,
          color: lightColorScheme.secondary),
      titleMedium: TextStyle(
          fontSize: TextSize.medium,
          fontWeight: FontWeight.w500,
          color: lightColorScheme.secondary),
      titleLarge: TextStyle(
          fontSize: TextSize.large,
          fontWeight: FontWeight.w500,
          color: lightColorScheme.secondary),
      bodySmall: TextStyle(
          fontSize: TextSize.small,
          fontWeight: FontWeight.w400,
          color: lightColorScheme.secondary),
      bodyMedium: TextStyle(
          fontSize: TextSize.medium,
          fontWeight: FontWeight.w400,
          color: lightColorScheme.secondary),
      bodyLarge: TextStyle(
          fontSize: TextSize.large,
          fontWeight: FontWeight.w400,
          color: lightColorScheme.secondary)),
);

const lightColorScheme = ColorScheme.light(
    primary: Color.fromARGB(255, 99,81,61),
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.black54,
    tertiary: Color(0xFF0E3A98),
    onTertiary: Color(0xFF002F64),
    error: Color(0xFFBA1A1A),
    background: Color.fromARGB(255, 244, 244, 244),
    surface: Color(0xFFFAFCFF),
    onSurface: Color(0xFF001F2A),
    onBackground: Color(0xFFFFFFFF),
    brightness: Brightness.light);


class TextSize {
  static const small = 14.0;
  static const medium = 18.0;
  static const large = 22.0;
}

const MaterialColor primarySwatch = MaterialColor(
  0xff5ec1ab,
  <int, Color>{
    50: Color(0xFFF1F8F7),
    100: Color(0xFFE3F1ED),
    200: Color(0xFFC6E2D9),
    300: Color(0xFFA8D2C5),
    400: Color(0xFF8BC3B2),
    500: Color(0xff5ec1ab),
    600: Color(0xFF4CBDA6),
    700: Color(0xFF3F9B88),
    800: Color(0xFF32756A),
    900: Color(0xFF253F4C),
  },
);
