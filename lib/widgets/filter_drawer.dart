import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key, required this.onFilterOptionSelected});

  final void Function(String, String) onFilterOptionSelected;

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  AnimalType selectedAnimalType = AnimalType.dog;
  dynamic selectedBreed;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Filter Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Row(
            children: [
              const Text(
                'Animal:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<AnimalType>(
                value: selectedAnimalType,
                onChanged: (AnimalType? value) {
                  setState(() {
                    selectedAnimalType = value ?? AnimalType.dog;
                    selectedBreed =
                        null; // Reset selected breed when animal type changes
                  });
                },
                items: [
                  const DropdownMenuItem<AnimalType>(
                    value: null,
                    child: Text('Select Animal Type'),
                  ),
                  ...AnimalType.values
                      .map<DropdownMenuItem<AnimalType>>((AnimalType value) {
                    return DropdownMenuItem<AnimalType>(
                      value: value,
                      child: Text('${value.toString().split('.').last}'),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Breed:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<dynamic>(
                value: selectedBreed,
                onChanged: (dynamic? value) {
                  setState(() {
                    selectedBreed = value;
                  });
                  widget.onFilterOptionSelected(
                      'breed', value?.toString() ?? '');
                  // Navigator.pop(context);
                },
                items: getBreedDropdownItems(selectedAnimalType),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Color:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<AnimalColor>(
                value: AnimalColor.brown,
                onChanged: (AnimalColor? value) {
                  widget.onFilterOptionSelected(
                      'color', value?.toString() ?? '');
                  //  Navigator.pop(context);
                },
                items: AnimalColor.values
                    .map<DropdownMenuItem<AnimalColor>>((AnimalColor value) {
                  return DropdownMenuItem<AnimalColor>(
                    value: value,
                    child: Text('${value.toString().split('.').last}'),
                  );
                }).toList(),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              widget.onFilterOptionSelected('age', value);
            },
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<dynamic>> getBreedDropdownItems(AnimalType animalType) {
    List<DropdownMenuItem<dynamic>> breedItems = [];

    List<Enum> getEnumValues(AnimalType animalType) {
      switch (animalType) {
        case AnimalType.dog:
          return DogBreed.values;
        case AnimalType.cat:
          return CatBreed.values;
        case AnimalType.bird:
          return BirdBreed.values;
        default:
          return [];
      }
    }

    List<Enum> enumValues = getEnumValues(animalType);
    // print('Enum values for $animalType: $enumValues');

    breedItems = enumValues.map<DropdownMenuItem<dynamic>>((Enum value) {
      return DropdownMenuItem<dynamic>(
        value: value,
        child: Text('${value.toString().split('.').last}'),
      );
    }).toList();

    return breedItems;
  }
}
