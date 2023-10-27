import 'package:flutter/material.dart';
import 'package:adoption_app/widgets/categories_grid_item.dart';
import 'package:adoption_app/dummy_data/animal_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Adopt'),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2, // Border width
              ),
            ),
            child: IconButton(
              icon: const Icon(
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 50, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Replace with the actual number of buttons
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button tap
                    },
                    child: Text('Category $index'),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio:
                    3 / 4, // Adjust the aspect ratio for better item spacing
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                for (final animal in dummyAnimals)
                  CategoryGridItem(animal: animal)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
