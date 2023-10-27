import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;

  AnimalDetailScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250, // Set the image container height
            child: Image.network(
              animal.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  animal.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.pets),
                  title: const Text("Type"),
                  subtitle: Text(animal.type),
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text("Breed"),
                  subtitle: Text(animal.breed),
                ),
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text("Color"),
                  subtitle: Text(animal.color),
                ),
                ListTile(
                  leading: const Icon(Icons.cake),
                  title: const Text("Age"),
                  subtitle: Text("${animal.age} years"),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_run),
                  title: const Text("Activity Level"),
                  subtitle: Text(animal.activity_level),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
