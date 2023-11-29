import 'package:adoption_app/firebase_options.dart';
import 'package:adoption_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:adoption_app/widgets/add_animal_form.dart';
//import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const App());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}
