import 'package:adoption_app/models/animal.dart';
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

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Animal> displayedAnimals = dummyAnimals; // Initial list to display
  List<Animal> filteredAnimals = [];

  void handleFilterOptionSelected(String attribute, String value) {
    // Convert enum values to strings
    if (attribute == 'Sex') {
      value = value
          .split('.')
          .last
          .toLowerCase(); // Convert AnimalSex.male to 'male'
    }
    if (attribute == 'Activity') {
      value = value
          .split('.')
          .last
          .toLowerCase(); // Convert AnimalActivity.high to 'high'
    }

    // Apply filters
    setState(() {
      filteredAnimals = applyFilters(attribute, value);
    });

    // Print the filtered list for debugging
    print('Filtered list: $filteredAnimals');
  }

  List<Animal> applyFilters(String attribute, String value) {
    List<Animal> filteredList = dummyAnimals;

    if (attribute == 'breed') {
      filteredList = filteredList.where((animal) {
        return animal.breed.toLowerCase() == value.toLowerCase();
      }).toList();
    } else if (attribute == 'Activity') {
      print('Filtering by activity: $value');
      filteredList = filteredList.where((animal) {
        return animal.activityLevel.toLowerCase() == value.toLowerCase();
      }).toList();
    } else if (attribute == 'Sex') {
      print('Filtering by sex: $value');
      filteredList = filteredList.where((animal) {
        return animal.sex.toLowerCase() == value.toLowerCase();
      }).toList();
    } else if (attribute == 'age') {
      filteredList = filteredList.where((animal) {
        return animal.age.toString() == value;
      }).toList();
    }

    // Add logic to check if all filters are satisfied
    filteredList = dummyAnimals
        .where((animal) =>
            // Add conditions here for other filters
            (attribute != 'breed' ||
                animal.breed.toLowerCase() == value.toLowerCase()) &&
            (attribute != 'Activity' ||
                animal.activityLevel.toLowerCase() == value.toLowerCase()) &&
            (attribute != 'Sex' ||
                animal.sex.toLowerCase() == value.toLowerCase()) &&
            (attribute != 'age' || animal.age.toString() == value))
        .toList();

    print('Filtered list: $filteredList');
    return filteredList;
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: displayedAnimals.length,
              itemBuilder: (context, index) {
                return CategoryGridItem(
                    animal: filteredAnimals.isEmpty
                        ? dummyAnimals[index]
                        : filteredAnimals[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
