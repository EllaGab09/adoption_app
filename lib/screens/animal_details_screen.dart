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
          // Display the animal's image
          Image.network(
            animal.imageUrl,
            fit: BoxFit.cover,
            height: 200, // Adjust the height as needed
            width: double.infinity,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("Description"),
            subtitle: Text(animal.description),
          ),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text("Type"),
            subtitle: Text(animal.type),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text("Breed"),
            subtitle: Text(animal.breed),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("Color"),
            subtitle: Text(animal.color),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text("Age"),
            subtitle: Text(animal.age.toString()),
          ),
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text("Activity Level"),
            subtitle: Text(animal.activity_level),
          ),
        ],
      ),
    );
  }
}
