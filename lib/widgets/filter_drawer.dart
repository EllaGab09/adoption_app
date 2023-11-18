import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({
    Key? key,
    required this.onFilterOptionSelected,
    required this.selectedSex,
    required this.selectedActivity,
    required this.selectedBreeds,
    required this.selectedAge,
  }) : super(key: key);

  final void Function(String, String) onFilterOptionSelected;
  final AnimalSex selectedSex;
  final AnimalActivity selectedActivity;
  final Set<String> selectedBreeds;
  final RangeValues selectedAge;

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  Map<AnimalType, Set<dynamic>> selectedBreedsMap = {};
  Map<AnimalType, bool> isTypeCheckedMap = {};

  AnimalActivity _selectedActivity = AnimalActivity.unspecified;
  AnimalSex _selectedSex = AnimalSex.unspecified;
  late RangeValues _selectedAge;

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  void initState() {
    super.initState();
    _selectedActivity = widget.selectedActivity;
    _selectedSex = widget.selectedSex;
    _selectedAge = widget.selectedAge;
    selectedBreedsMap = widget.selectedBreeds.fold(
      <AnimalType, Set<dynamic>>{},
      (map, breed) {
        final type = getBreedType(breed);
        if (!map.containsKey(type)) {
          map[type] = <dynamic>{};
        }
        map[type]!.add(breed);
        return map;
      },
    );
    isTypeCheckedMap = selectedBreedsMap.map((type, breeds) {
      return MapEntry(type, breeds.isNotEmpty);
    });
  }

  AnimalType getBreedType(String breed) {
    if (DogBreed.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.dog;
    } else if (CatBreed.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.cat;
    } else if (BirdBreed.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.bird;
    } else if (ReptileType.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.reptile;
    } else if (FishType.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.fish;
    } else if (SmallAnimals.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.smallAnimals;
    } else {
      return AnimalType.dog;
    }
  }

  List<Animal> applyFilters(List<Animal> animals) {
    return animals.where((animal) {
      // Filter by type
      if (isTypeCheckedMap.isNotEmpty &&
          isTypeCheckedMap.containsValue(true) &&
          !isTypeCheckedMap[animal.type]!) {
        print('Type Filter - Excluding: ${animal.type}');
        return false;
      }

      // Filter by breeds
      if (selectedBreedsMap.isNotEmpty &&
          (!selectedBreedsMap.containsKey(animal.type) ||
              !selectedBreedsMap[animal.type]!.contains(animal.breed))) {
        print('Breed Filter - Excluding: ${animal.breed}');
        return false;
      }

      // Filter by activity
      if (_selectedActivity != AnimalActivity.unspecified &&
          animal.activityLevel != _selectedActivity.toString()) {
        print('Activity Filter - Excluding: ${animal.activityLevel}');
        return false;
      }

      // Filter by sex
      if (_selectedSex != AnimalSex.unspecified &&
          animal.sex != _selectedSex.toString()) {
        print('Sex Filter - Excluding: ${animal.sex}');
        return false;
      }

      // Filter by age between
      if (_selectedAge.start != 0 &&
          (_selectedAge.end == 15
              ? animal.age < _selectedAge.start
              : (animal.age < _selectedAge.start ||
                  animal.age <= _selectedAge.end))) {
        print('Age Filter - Excluding: ${animal.age}');
        return false;
      }

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
                fontSize: 24,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expandIconColor: Colors.transparent,
              dividerColor: Colors.transparent,
              expansionCallback: (int index, bool isExpanded) {
                var animalType = AnimalType.values[index];

                setState(() {
                  isTypeCheckedMap[animalType] = isExpanded;
                  if (!isExpanded) {
                    selectedBreedsMap[animalType] = <dynamic>{};
                  }
                });

                widget.onFilterOptionSelected(
                    'breed', selectedBreedsMap.values.join(', '));
              },
              children: AnimalType.values.map<ExpansionPanel>(
                (AnimalType animalType) {
                  return ExpansionPanel(
                    canTapOnHeader: false,
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: getBreedDropdownItems(animalType).length,
                      itemBuilder: (context, index) {
                        var breed = getBreedDropdownItems(animalType)[index];
                        return CheckboxListTile(
                          dense: true,
                          title: Text(
                              capitalize(breed.toString().split('.').last)),
                          contentPadding: EdgeInsets.zero,
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
          const SizedBox(
            height: 15,
          ),
          Text(
            (_selectedAge.start == 0 && _selectedAge.end == 15)
                ? 'Filtering: All ages'
                : (_selectedAge.start == 0)
                    ? 'Filtering:  Up to ${_selectedAge.end.round()}'
                    : (_selectedAge.end == 15)
                        ? 'Filtering:  From ${_selectedAge.start.round()} and up'
                        : 'Filtering:  Between ${_selectedAge.start.round()} and ${_selectedAge.end.round()}',
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              const Text(
                'Age:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              RangeSlider(
                values: _selectedAge,
                onChanged: (RangeValues values) {
                  setState(() {
                    _selectedAge = values;
                  });
                  widget.onFilterOptionSelected(
                    'age',
                    '${values.start.round()} - ${values.end.round()}',
                  );
                },
                min: 0,
                max: 15,
                divisions: 15,
                labels: RangeLabels(
                  _selectedAge.start.round().toString(),
                  _selectedAge.end.round().toString(),
                ),
              ),
            ],
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
