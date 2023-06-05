import 'package:flutter/material.dart';

class CoreTheme {
  static final ThemeData _themeDataLight = ThemeData(
    // brightness: Brightness.light,
    applyElevationOverlayColor: true,
    fontFamily: 'Roboto',
    primaryColor: kPrimaryLightColor,
    colorScheme: ColorScheme.fromSeed(
      primary: kPrimaryLightColor,
      seedColor: kPrimaryLightColor,
      secondary: kSecondaryGreen,
      brightness: Brightness.light
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        color: kTextColorPrimaryLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: kTextColorPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: kTextColorPrimaryLight,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        color: kTextColorPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: kTextColorPrimaryLight,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: kTextColorPrimaryLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: kTextColorPrimaryLight,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: kShadowColor,
      scrolledUnderElevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      foregroundColor: Colors.white,
      backgroundColor: kPrimaryLightColor,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      elevation: 3,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.bold,
            wordSpacing: 0,
            letterSpacing: 0,
            fontSize: 13,
          ),
        ),
      ),
    ),
  );
  static final ThemeData _themeDataDark = ThemeData(
    // brightness: Brightness.dark,
    applyElevationOverlayColor: true,
    fontFamily: 'Roboto',
    primaryColor: kPrimaryLightColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryLightColor,
      secondary: kSecondaryGreen,
      brightness: Brightness.dark
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        color: kTextColorPrimaryLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: kTextColorPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: kTextColorPrimaryLight,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: kTextColorPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: kTextColorPrimaryLight,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: kTextColorPrimaryLight,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: kShadowColor,
      scrolledUnderElevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: kTextColorPrimaryLight,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      foregroundColor: kTextColorPrimaryLight,
      backgroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      elevation: 3,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.bold,
            wordSpacing: 0,
            letterSpacing: 0,
            fontSize: 13,
          ),
        ),
      ),
    ),
  );

  static ThemeData get lightTheme => _themeDataLight;
  static ThemeData get darkTheme => _themeDataDark;
}

//Color

//Light Theme
const kPrimaryLightColor = Color(0xff005EA3);
const kPrimaryLightColor2 = Color(0xff06A6D7);
const kDividerColor = Color(0xFFF4F6FA);
const kTextFieldLightColor = Color(0xFFeff3f4);
const kCardLightColor = Color(0xFFf5f8fe);
const kBackground = Color(0xFFD9D9D9);
const kBackgroundBottomBar = Color(0xFFebf1f1);

// Text Colors
const kTextColorPrimaryLight = Color(0xFF030F2D);
const kTextColor = Colors.black;
const kTextColorBody = Colors.black87;
const kTextColorGrey = Color(0xFFB6B5BA);

//Secondary Colors
const kSecondaryRed = Color(0xFFeb717c);
const kSecondaryBlue = Color(0xFF00899E);
const kSecondaryBlueLight = Color.fromARGB(255, 0, 204, 235);
const kSecondaryGreen = Color.fromARGB(255, 58, 205, 151);
const kSecondaryYellow = Color(0xFFFFC633);

//
const kDefaultBorderRadius = 12.0;
const kShadowColor = Color.fromRGBO(149, 157, 165, 0.2);
const kDefaultBoxShadow = BoxShadow(
  color: kShadowColor,
  offset: Offset(0, 8),
  blurRadius: 24,
);

const kDefaultGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kPrimaryLightColor,
    kPrimaryLightColor2
  ]
);
const kDefaultIconGradient = RadialGradient(
    center: Alignment.topCenter,
    tileMode: TileMode.mirror,
    radius: 1,
    colors: [
      kPrimaryLightColor,
      kPrimaryLightColor2
    ]
);
