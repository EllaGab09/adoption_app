import 'package:adoption_app/screens/login_screen.dart';
import 'screens/categories_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CategoriesScreen());
  }
}
