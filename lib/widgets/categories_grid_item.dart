import 'package:adoption_app/screens/animal_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

/// A widget representing a grid item for a category.
///
/// This widget is used to display a category in a grid layout.
/// It is typically used in a [GridView] or [Wrap] widget.
class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.animal});
  final Animal animal;

  // Define a constant variable for borderRadius
  static BorderRadius gridItemBorderRadius = BorderRadius.circular(15);

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AnimalDetailScreen(
              animal: animal,
            ),
          ),
        );
      },
      child: Card(
        //color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              SizedBox(
                height: 130, // Set a fixed height for the image container
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
              const SizedBox(
                height: 5,
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
                maxLines: 2, // Set the maximum number of lines
                overflow: TextOverflow.ellipsis, // Overflow style
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "${animal.sex} ${capitalize(animal.breed)}",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    "Age: ${animal.age}",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Activity: ${animal.activityLevel}",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    animal.health,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
