import 'package:adoption_app/dummy_data/animal_data.dart';
import 'package:adoption_app/screens/adoption_application_details_adoption_center.dart';
import 'package:adoption_app/screens/adoption_application_details_user.dart';
import 'package:adoption_app/screens/login_screen.dart';
import 'package:adoption_app/screens/tabs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:adoption_app/firebase_options.dart';
import 'package:adoption_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:adoption_app/widgets/add_animal_form.dart';
//import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';

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
  runApp(const App());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: theme,
      home: const LoginScreen(),
      /* home: AdoptionApplicationDetailsAC(
        adoptionCenter: "Happy Paws Adoption Center",
        animalInfo: "Dog",
        userName: "John Doe",
        userMessage: "I would like to adopt a dog.",
        animal: dummyAnimals[0],
      ), */

      routes: {
        '/login': (context) => const LoginScreen(),
        '/tabs': (context) => const TabsScreen(),
      },
    );
  }
}
