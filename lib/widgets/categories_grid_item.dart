import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

class CategoryGridItem extends StatelessWidget {
  final Animal animal;

  const CategoryGridItem({super.key, required this.animal});

// Define a constant variable for borderRadius
  static BorderRadius gridItemBorderRadius = BorderRadius.circular(30);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: gridItemBorderRadius,
            child: Image.network(
              animal.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Text(
            animal.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            animal.description,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
