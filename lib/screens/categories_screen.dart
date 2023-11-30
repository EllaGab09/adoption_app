import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/models/response.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/widgets/categories_grid_item.dart';
import 'package:adoption_app/widgets/filter_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// This class represents the screen that displays categories for adoption.
/// It is a stateful widget that can be updated dynamically.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  Response response = Response();
  late List<Animal> displayedAnimals;
  List<Animal> filteredAnimals = [];
  Set<String> selectedBreeds = {};
  AnimalActivity selectedActivity = AnimalActivity.unspecified;
  AnimalSex selectedSex = AnimalSex.unspecified;
  RangeValues selectedAge = const RangeValues(0, 15);
  List<AnimalType> selectedTypes = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
    handleFilterOptionSelected('resetFilters', null);
  }

  Future<List<Animal>> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('animals').get();

      return querySnapshot.docs.map((doc) {
        return Animal(
          activityLevel: (doc.data() as Map<String, dynamic>?)
                      ?.containsKey('activityLevel') ??
                  false
              ? doc['activityLevel']
              : '',
          adoptionCenterId: (doc.data() as Map<String, dynamic>?)
                      ?.containsKey('adoptionCenterID') ??
                  false
              ? doc['adoptionCenterID']
              : '',
          age:
              (doc.data() as Map<String, dynamic>?)?.containsKey('age') ?? false
                  ? doc['age']
                  : 0,
          availability: (doc.data() as Map<String, dynamic>?)
                      ?.containsKey('availability') ??
                  false
              ? doc['availability']
              : false,
          breed: (doc.data() as Map<String, dynamic>?)?.containsKey('breed') ??
                  false
              ? doc['breed']
              : '',
          description: (doc.data() as Map<String, dynamic>?)
                      ?.containsKey('description') ??
                  false
              ? doc['description']
              : '',
          health:
              (doc.data() as Map<String, dynamic>?)?.containsKey('health') ??
                      false
                  ? doc['health']
                  : '',
          imageUrl:
              (doc.data() as Map<String, dynamic>?)?.containsKey('imageUrl') ??
                      false
                  ? doc['imageUrl']
                  : '',
          name: (doc.data() as Map<String, dynamic>?)?.containsKey('name') ??
                  false
              ? doc['name']
              : '',
          sex:
              (doc.data() as Map<String, dynamic>?)?.containsKey('sex') ?? false
                  ? doc['sex']
                  : '',
          type: (doc.data() as Map<String, dynamic>?)?.containsKey('type') ??
                  false
              ? doc['type']
              : '',
        );
      }).toList();
    } catch (error) {
      response.message;
      return [];
    }
  }

  Future<void> handleFilterOptionSelected(
      String attribute, dynamic value) async {
    List<Animal> animals =
        await fetchDataFromFirestore(); // Reload data from Firestore
    setState(() {
      displayedAnimals = animals;
    });

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
    } else if (attribute == 'resetFilters') {
      // Reset all filters
      selectedTypes = [];
      selectedBreeds = <String>{};
      selectedActivity = AnimalActivity.unspecified;
      selectedSex = AnimalSex.unspecified;
      selectedAge = const RangeValues(0, 15);

      // Fetch all animals from Firestore again
      List<Animal> animals = await fetchDataFromFirestore();
      setState(() {
        displayedAnimals = animals;
      });
    }

    // Apply filters
    setState(() {
      filteredAnimals = applyFilters();
    });
  }

  List<Animal> applyFilters() {
    List<Animal> filteredList = displayedAnimals;

    // Apply type filter
    if (selectedTypes.isNotEmpty) {
      filteredList = filteredList.where((animal) {
        String animalType = animal.type.trim().toLowerCase();
        return selectedTypes.any((type) =>
            animalType == type.toString().split('.').last.toLowerCase());
      }).toList();
    } else {
      // If no types are selected, include all types in the result
      filteredList = displayedAnimals;
    }

    // Breed filter
    if (selectedBreeds.isNotEmpty) {
      filteredList = filteredList.where((animal) {
        String animalBreed = animal.breed.trim().toLowerCase();
        return selectedBreeds.contains(animalBreed);
      }).toList();
    } else {
      // If no breeds are selected, include all breeds in the result
    }

    // Apply activity filter
    if (selectedActivity != AnimalActivity.unspecified) {
      filteredList = filteredList.where((animal) {
        return animal.activityLevel.toLowerCase() ==
            selectedActivity.toString().split('.').last;
      }).toList();
    }

    // Apply sex filter
    if (selectedSex != AnimalSex.unspecified) {
      filteredList = filteredList.where((animal) {
        return animal.sex.toLowerCase() ==
            selectedSex.toString().split('.').last;
      }).toList();
    }

    // Apply age filter
    if (selectedAge.start != 0 || selectedAge.end != 15) {
      filteredList = filteredList.where((animal) {
        return ((animal.age >= selectedAge.start &&
                animal.age <= selectedAge.end) ||
            (selectedAge.end == 15 && animal.age >= 15));
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LogoAppBar(),
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
                    child: Column(
                      children: [
                        Icon(
                          Icons.tune,
                          color: Theme.of(context)
                              .iconTheme
                              .color, // Set the color for the icon
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1?.color ??
                                    Colors.black, // Set the color for the text
                          ),
                        ),
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
            child: filteredAnimals.isEmpty
                ? Center(
                    // Display a message when the list is empty
                    child: Text('No animals found.'),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: filteredAnimals.length,
                    itemBuilder: (context, index) {
                      return CategoryGridItem(
                        animal: filteredAnimals[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
