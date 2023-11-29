import 'package:adoption_app/screens/login_screen.dart';
import 'package:adoption_app/services/login_state_authentication.dart';
import 'package:adoption_app/widgets/tabs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Colors.lightGreenAccent,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
  ),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already logged in
  bool stayLoggedIn = await StayLogedInService.isLoggedIn();
  print("Stay logged in: $stayLoggedIn");

  Widget initialScreen =
      stayLoggedIn ? const TabsScreen() : const LoginScreen();

  runApp(ProviderScope(child: App(initialScreen: initialScreen)));
}

class App extends StatelessWidget {
  final Widget initialScreen;

  const App({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialScreen,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/tabs': (context) => const TabsScreen(),
      },
    );
  }
}
