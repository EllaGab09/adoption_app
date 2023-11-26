import 'package:adoption_app/screens/login_screen.dart';
//import 'package:adoption_app/widgets/add_animal_form.dart';
//import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}
