import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  applyElevationOverlayColor: false,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1460A5),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    buttonColor: Color(0xFF1460A5),
    colorScheme: lightColorScheme,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1460A5),
    selectedItemColor: Color.fromARGB(255, 32, 125, 211),
    unselectedItemColor: Color(0xFF1460A5),
  ),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 32, 118, 199),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD3E4FF),
  onPrimaryContainer: Color(0xFF001C38),
  secondary: Color(0xFF545F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E3F8),
  onSecondaryContainer: Color(0xFF111C2B),
  tertiary: Color(0xFF884588),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD6F9),
  onTertiaryContainer: Color(0xFF37003B),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8FDFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFDFE2EB),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFFA2C9FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF1460A5),
  outlineVariant: Color(0xFFC3C6CF),
  scrim: Color(0xFF000000),
);

final ThemeData darkTheme = ThemeData(
  applyElevationOverlayColor: false,
  brightness: Brightness.dark,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    colorScheme: darkColorScheme,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    selectedItemColor: Color.fromARGB(255, 252, 252, 252),
    unselectedItemColor: Color.fromARGB(255, 87, 89, 92),
  ),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA2C9FF),
  onPrimary: Color(0xFF00315B),
  primaryContainer: Color(0xFF004881),
  onPrimaryContainer: Color(0xFFD3E4FF),
  secondary: Color(0xFFBCC7DB),
  onSecondary: Color(0xFF263141),
  secondaryContainer: Color(0xFF3C4758),
  onSecondaryContainer: Color(0xFFD7E3F8),
  tertiary: Color(0xFFFBACF7),
  onTertiary: Color(0xFF531356),
  tertiaryContainer: Color(0xFF6D2D6F),
  onTertiaryContainer: Color(0xFFFFD6F9),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color.fromARGB(255, 6, 109, 226),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C6CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color.fromARGB(255, 6, 76, 92),
  inversePrimary: Color(0xFF1460A5),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA2C9FF),
  outlineVariant: Color(0xFF43474E),
  scrim: Color(0xFF000000),
);
