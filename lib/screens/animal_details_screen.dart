import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;

  AnimalDetailScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name), // Set the title of the animal
      ),
      body: Column(
        children: [
          // Display animal details here
        ],
      ),
    );
  }
}
