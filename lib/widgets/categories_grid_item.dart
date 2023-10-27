import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

class CategoryGridItem extends StatelessWidget {
  final Animal animal;

  const CategoryGridItem({super.key, required this.animal});

// Define a constant variable for borderRadius
  static BorderRadius gridItemBorderRadius = BorderRadius.circular(100);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.lightBlue,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 150, // Set a fixed height for the image container
              child: ClipRRect(
                borderRadius: gridItemBorderRadius,
                child: Image.network(
                  animal.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
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
      ),
    );
  }
}
