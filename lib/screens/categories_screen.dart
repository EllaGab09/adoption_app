import 'package:flutter/material.dart';
import 'package:adoption_app/widgets/categories_grid_item.dart';
import 'package:adoption_app/dummy_data/animal_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2, // Border width
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              onPressed: () {
                // Handle the button's action (e.g., open user profile)
              },
            ),
          ),
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio:
              3 / 4, // Adjust the aspect ratio for better item spacing
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final animal in dummyAnimals) CategoryGridItem(animal: animal)
        ],
      ),
    );
  }
}
