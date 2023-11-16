import 'package:adoption_app/screens/user_profile_screen.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/widgets/categories_grid_item.dart';
import 'package:adoption_app/dummy_data/animal_data.dart';
import 'package:adoption_app/widgets/filter_drawer.dart';

import 'package:adoption_app/models/user.dart';

//Temp Dummy
final dummyUser = User(
  id: '1',
  imageUrl:
      "https://nebulae-assets.s3.amazonaws.com/3b56d17152bd46c295797a7eaab1f244.jpg",
  firstname: 'John',
  surname: 'Doe',
  email: 'john@example.com',
  password: 'securepassword',
  age: 30,
  address: UserAddress(
    street: '123 Main St',
    city: 'Anytown',
    zipCode: '12345',
    country: 'United States',
  ),
);

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void handleFilterOptionSelected(String attribute, String value) {
    // Implement your filter logic based on the selected attribute and value
    print('Selected filter option: $attribute - $value');
    // Add your filtering logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        onProfilePressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(user: dummyUser),
            ),
          );
        },
      ),
      drawer: FilterDrawer(onFilterOptionSelected: handleFilterOptionSelected),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Builder(
                  builder: (context) => TextButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.tune),
                        Text('Filter'),
                      ],
                    ),
                  ),
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
