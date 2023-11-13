import 'package:adoption_app/screens/login_screen.dart';
//import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.amber,
    accentColor: Colors.teal,
    backgroundColor: Colors.green,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: const LoginScreen());
  }
}
