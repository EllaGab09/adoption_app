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
    required this.selectedTypes,
  }) : super(key: key);

  final void Function(String, dynamic) onFilterOptionSelected;
  final AnimalSex selectedSex;
  final AnimalActivity selectedActivity;
  final Set<String> selectedBreeds;
  final RangeValues selectedAge;
  final List<AnimalType> selectedTypes;

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  Map<AnimalType, Set<dynamic>> _selectedBreedsMap = {};
  Map<AnimalType, bool> isTypeCheckedMap = {};
  AnimalActivity _selectedActivity = AnimalActivity.unspecified;
  AnimalSex _selectedSex = AnimalSex.unspecified;
  late List<AnimalType> selectedTypes;
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
    selectedTypes = widget.selectedTypes;
    _selectedBreedsMap = widget.selectedBreeds.fold(
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
    isTypeCheckedMap = _selectedBreedsMap.map((type, breeds) {
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
                  isTypeCheckedMap[animalType] = !isExpanded;
                  if (!isExpanded) {
                    _selectedBreedsMap[animalType] = <dynamic>{};
                  }
                });

                // Only call the 'breed' filter callback when the panel is expanded or collapsed
                widget.onFilterOptionSelected(
                  'breed',
                  _selectedBreedsMap.values.join(', '),
                );
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
                              value: selectedTypes.contains(animalType),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    // Update selectedTypes when the checkbox is checked
                                    selectedTypes.add(animalType);
                                  } else {
                                    // Uncheck the checkbox and remove the type from selectedTypes
                                    selectedTypes.remove(animalType);
                                  }
                                  isTypeCheckedMap[animalType] = value;
                                });

                                // Only call the 'type' filter callback when the checkbox is clicked
                                if (value != null && value) {
                                  widget.onFilterOptionSelected(
                                    'type',
                                    selectedTypes,
                                  );
                                }
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
                            capitalize(breed.toString().split('.').last),
                          ),
                          contentPadding: EdgeInsets.zero,
                          value:
                              _selectedBreedsMap[animalType]?.contains(breed) ??
                                  false,
                          onChanged: (bool? value) {
                            print(
                                'Selected Animal Type: $animalType, Selected Breed: $breed');
                            setState(() {
                              if (value!) {
                                _selectedBreedsMap.putIfAbsent(
                                    animalType, () => <dynamic>{});
                                _selectedBreedsMap[animalType]!.add(breed);
                              } else {
                                _selectedBreedsMap[animalType]!.remove(breed);
                                if (_selectedBreedsMap[animalType]!.isEmpty) {
                                  _selectedBreedsMap.remove(animalType);
                                }
                              }
                            });
                            widget.onFilterOptionSelected(
                              'breed',
                              _selectedBreedsMap.values.join(', '),
                            );
                          },
                        );
                      },
                    ),
                    isExpanded: isTypeCheckedMap.containsKey(animalType)
                        ? isTypeCheckedMap[animalType]!
                        : _selectedBreedsMap.containsKey(animalType),
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
                      'Activity',
                      value?.toString() ?? '',
                    );
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
                      'Sex',
                      value?.toString() ?? '',
                    );
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
            (_selectedAge.start == _selectedAge.end)
                ? 'Filtering: Only ${_selectedAge.start.round()}'
                : (_selectedAge.start == 0 && _selectedAge.end == 15)
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
