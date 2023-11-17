import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key, required this.onFilterOptionSelected});

  final void Function(String, String) onFilterOptionSelected;

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  Map<AnimalType, Set<dynamic>> selectedBreedsMap = {};
  Map<AnimalType, bool> isTypeCheckedMap = {};

  AnimalActivity _selectedActivity = AnimalActivity.unspecified;
  AnimalSex _selectedSex = AnimalSex.unspecified;

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  List<Animal> applyFilters(List<Animal> animals) {
    return animals.where((animal) {
      // Filter by type
      if (isTypeCheckedMap.isNotEmpty && !isTypeCheckedMap[animal.type]!) {
        return false;
      }

      // Filter by breeds
      if (selectedBreedsMap.isNotEmpty &&
          (!selectedBreedsMap.containsKey(animal.type) ||
              !selectedBreedsMap[animal.type]!.contains(animal.breed))) {
        return false;
      }

      // Filter by activity
      if (_selectedActivity != AnimalActivity.unspecified &&
          animal.activityLevel != _selectedActivity.toString()) {
        return false;
      }

      // Filter by sex
      if (_selectedSex != AnimalSex.unspecified &&
          animal.sex != _selectedSex.toString()) {
        return false;
      }

      // Filter by age
      /* if (animal.age != null && _selectedAge != null &&
        animal.age != int.tryParse(_selectedAge)) {
      return false;
    } */

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text(
              'Filters',
              style: TextStyle(
                //color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            color: Colors.transparent, // Set background color to transparent
            child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expandIconColor: Colors.transparent,
              dividerColor:
                  Colors.transparent, // Set divider color to transparent
              expansionCallback: (int index, bool isExpanded) {
                var animalType = AnimalType.values[index];

                setState(() {
                  isTypeCheckedMap[animalType] = isExpanded;
                  if (!isExpanded) {
                    // If the type is not expanded, expand it without checking the breeds
                    selectedBreedsMap[animalType] = <dynamic>{};
                  }
                });

                widget.onFilterOptionSelected(
                    'breed', selectedBreedsMap.values.join(', '));
              },
              children: AnimalType.values.map<ExpansionPanel>(
                (AnimalType animalType) {
                  return ExpansionPanel(
                    canTapOnHeader: false, // Disable tapping on the header
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(capitalize(
                                animalType.toString().split('.').last)),
                            const SizedBox(width: 10),
                            Checkbox(
                              value: isTypeCheckedMap.containsKey(animalType)
                                  ? isTypeCheckedMap[animalType]
                                  : selectedBreedsMap.containsKey(animalType),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    selectedBreedsMap[animalType] = <dynamic>{};
                                  } else {
                                    selectedBreedsMap.remove(animalType);
                                  }
                                  isTypeCheckedMap[animalType] = value;
                                });
                                widget.onFilterOptionSelected('breed',
                                    selectedBreedsMap.values.join(', '));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    body: ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable scrolling in the body
                      shrinkWrap: true,
                      itemCount: getBreedDropdownItems(animalType).length,
                      itemBuilder: (context, index) {
                        var breed = getBreedDropdownItems(animalType)[index];
                        return CheckboxListTile(
                          dense: true, // Make the ListTile dense
                          title: Text(
                              capitalize(breed.toString().split('.').last)),
                          contentPadding:
                              EdgeInsets.zero, // Remove padding around ListTile
                          value: selectedBreedsMap.containsKey(animalType) &&
                              selectedBreedsMap[animalType]!.contains(breed),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                selectedBreedsMap.putIfAbsent(
                                    animalType, () => <dynamic>{});
                                selectedBreedsMap[animalType]!.add(breed);
                              } else {
                                selectedBreedsMap[animalType]!.remove(breed);
                                if (selectedBreedsMap[animalType]!.isEmpty) {
                                  selectedBreedsMap.remove(animalType);
                                }
                              }
                            });
                            widget.onFilterOptionSelected(
                                'breed', selectedBreedsMap.values.join(', '));
                          },
                        );
                      },
                    ),
                    isExpanded: isTypeCheckedMap.containsKey(animalType)
                        ? isTypeCheckedMap[animalType]!
                        : selectedBreedsMap.containsKey(animalType),
                  );
                },
              ).toList(),
            ),
          ),
          Row(
            children: [
              const Text(
                'Activity:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<AnimalActivity>(
                value: _selectedActivity,
                onChanged: (AnimalActivity? value) {
                  setState(() {
                    widget.onFilterOptionSelected(
                        'Activity', value?.toString() ?? '');
                    _selectedActivity = value ?? AnimalActivity.unspecified;
                  });
                },
                items: AnimalActivity.values
                    .map<DropdownMenuItem<AnimalActivity>>(
                        (AnimalActivity value) {
                  return DropdownMenuItem<AnimalActivity>(
                    value: value,
                    child: Text(capitalize(value.toString().split('.').last)),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Sex:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<AnimalSex>(
                value: _selectedSex,
                onChanged: (AnimalSex? value) {
                  setState(() {
                    widget.onFilterOptionSelected(
                        'Sex', value?.toString() ?? '');
                    _selectedSex = value ?? AnimalSex.unspecified;
                  });
                },
                items: AnimalSex.values
                    .map<DropdownMenuItem<AnimalSex>>((AnimalSex value) {
                  return DropdownMenuItem<AnimalSex>(
                    value: value,
                    child: Text(capitalize(value.toString().split('.').last)),
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

  List<dynamic> getBreedDropdownItems(AnimalType animalType) {
    switch (animalType) {
      case AnimalType.dog:
        return DogBreed.values;
      case AnimalType.cat:
        return CatBreed.values;
      case AnimalType.bird:
        return BirdBreed.values;
      case AnimalType.reptile:
        return ReptileType.values;
      case AnimalType.fish:
        return FishType.values;
      case AnimalType.smallAnimals:
        return SmallAnimals.values;
      default:
        return [];
    }
  }
}
