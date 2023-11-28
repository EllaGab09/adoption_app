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
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  List<Animal> displayedAnimals = dummyAnimals; // Initial list to display
  List<Animal> filteredAnimals = [];
  Set<String> selectedBreeds = Set();
  AnimalActivity selectedActivity = AnimalActivity.unspecified;
  AnimalSex selectedSex = AnimalSex.unspecified;
  RangeValues selectedAge = const RangeValues(0, 15);
  List<AnimalType> selectedTypes = [];

  void handleFilterOptionSelected(String attribute, dynamic value) {
    print('handleFilterOptionSelected called from $attribute');
    if (attribute == 'type') {
      // Handling for Type
      if (value is List<AnimalType>) {
        selectedTypes = value;
      } else if (value is AnimalType) {
        selectedTypes = [value];
      } else if (value == null) {
        selectedTypes.clear();
      }
    } else if (attribute == 'Sex') {
      // Handling for Sex
      value = value.split('.').last.toLowerCase();
      selectedSex = AnimalSex.values
          .firstWhere((sex) => sex.toString().split('.').last == value);
    } else if (attribute == 'Activity') {
      // Handling for Activity
      value = value.split('.').last.toLowerCase();
      selectedActivity = AnimalActivity.values.firstWhere(
          (activity) => activity.toString().split('.').last == value);
    } else if (attribute == 'breed') {
      // Handling for Breed
      if (value is String) {
        setState(() {
          final cleanBreed = value.split('.').last.trim().toLowerCase();
          if (selectedBreeds.contains(cleanBreed)) {
            selectedBreeds.remove(cleanBreed);
          } else {
            selectedBreeds.add(cleanBreed);
          }
        });
      } else if (value == null) {
        setState(() {
          selectedBreeds.clear();
        });
      }
    } else if (attribute == 'age') {
      // Handling for Age
      final ageValues = value.split(' - ');
      selectedAge = RangeValues(
        double.parse(ageValues[0]),
        double.parse(ageValues[1]),
      );
    }

    // Apply filters
    setState(() {
      filteredAnimals = applyFilters();
    });
  }

  List<Animal> applyFilters() {
    List<Animal> filteredList = dummyAnimals;

// Apply type filter
    if (selectedTypes.isNotEmpty) {
      print('Type Filter Applied: ${selectedTypes.toString()}');
      filteredList = filteredList.where((animal) {
        String animalType = animal.type.trim().toLowerCase();
        return selectedTypes.any((type) =>
            animalType == type.toString().split('.').last.toLowerCase());
      }).toList();
    } else {
      // If no types are selected, include all types in the result
      print('No Types Selected');
      filteredList = dummyAnimals;
    }
    print('After Type Filter: ${filteredList.map((animal) => animal.type)}');

    // Breed filter
    print('Before Breed Filter: $filteredList');
    if (selectedBreeds.isNotEmpty) {
      print('Breed Filter Applied: $selectedBreeds');
      filteredList = filteredList.where((animal) {
        String animalBreed = animal.breed.trim().toLowerCase();
        return selectedBreeds.contains(animalBreed);
      }).toList();
      print('After Breed Filter: $filteredList');
    } else {
      // If no breeds are selected, include all breeds in the result
      print('No Breeds Selected');
    }

    // Apply activity filter
    if (selectedActivity != AnimalActivity.unspecified) {
      print('Activity Filter Applied: ${selectedActivity.toString()}');
      filteredList = filteredList.where((animal) {
        return animal.activityLevel.toLowerCase() ==
            selectedActivity.toString().split('.').last;
      }).toList();
    }
    print(
        'After Activity Filter: ${filteredList.map((animal) => animal.type)}');

    // Apply sex filter
    if (selectedSex != AnimalSex.unspecified) {
      print('Sex Filter Applied: ${selectedSex.toString()}');
      filteredList = filteredList.where((animal) {
        return animal.sex.toLowerCase() ==
            selectedSex.toString().split('.').last;
      }).toList();
    }
    print('After Sex Filter: ${filteredList.map((animal) => animal.type)}');

    // Apply age filter
    if (selectedAge.start != 0 || selectedAge.end != 15) {
      print('Age Filter Applied: ${selectedAge.toString()}');
      filteredList = filteredList.where((animal) {
        return ((animal.age >= selectedAge.start &&
                animal.age <= selectedAge.end) ||
            (selectedAge.end == 15 && animal.age! >= 15));
      }).toList();
    }
    print('After Age Filter: ${filteredList.map((animal) => animal.type)}');

    setState(() {
      displayedAnimals = filteredList;
    });

    print('Filtered Animals Count: ${filteredList.length}');

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
      drawer: FilterDrawer(
        onFilterOptionSelected: handleFilterOptionSelected,
        selectedSex: selectedSex,
        selectedActivity: selectedActivity,
        selectedBreeds: selectedBreeds,
        selectedAge: selectedAge,
        selectedTypes: selectedTypes,
      ),
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
