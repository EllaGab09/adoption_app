import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        onProfilePressed: () {},
      ),
      body: const Center(
        child: Text('Nothing is here. Please add your favorite animals'),
      ),
    );
  }
}
