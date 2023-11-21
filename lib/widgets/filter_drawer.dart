// Import necessary packages and files
import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

// Define a FilterDrawer widget
class FilterDrawer extends StatefulWidget {
  // Constructor with required parameters for filter options
  const FilterDrawer({
    Key? key,
    required this.onFilterOptionSelected,
    required this.selectedSex,
    required this.selectedActivity,
    required this.selectedBreeds,
    required this.selectedAge,
    required this.selectedTypes,
  }) : super(key: key);

  // Callback function for handling filter option selection
  final void Function(String, dynamic) onFilterOptionSelected;
  // Selected filter options passed as parameters
  final AnimalSex selectedSex;
  final AnimalActivity selectedActivity;
  final Set<String> selectedBreeds;
  final RangeValues selectedAge;
  final List<AnimalType> selectedTypes;

  // Create the state for the FilterDrawer widget
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

// Define the state for the FilterDrawer widget
class _FilterDrawerState extends State<FilterDrawer> {
  // Maps to store selected breeds and type checkboxes
  Map<AnimalType, Set<dynamic>> _selectedBreedsMap = {};
  Map<AnimalType, bool> isTypeCheckedMap = {};

  // Selected activity, sex, age, and types
  AnimalActivity _selectedActivity = AnimalActivity.unspecified;
  AnimalSex _selectedSex = AnimalSex.unspecified;
  late List<AnimalType> selectedTypes;
  late RangeValues _selectedAge;

  // Function to capitalize the first letter of a string
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  // Initialize state with selected filter options
  @override
  void initState() {
    super.initState();
    _selectedActivity = widget.selectedActivity;
    _selectedSex = widget.selectedSex;
    _selectedAge = widget.selectedAge;
    selectedTypes = widget.selectedTypes;

    // Populate selected breeds map based on selected breeds
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

    // Initialize type checkboxes
    isTypeCheckedMap = selectedTypes.asMap().map((index, type) {
      return MapEntry(type, true);
    });
  }

  // Function to determine the type of a breed
  AnimalType getBreedType(String breed) {
    // Check the type of breed and return the corresponding AnimalType
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

  // Function to get a list of breed items based on the animal type
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

  // Build the UI for the FilterDrawer widget
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header with the title 'Filters'
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
          // Container for filter options
          Container(
            color: Colors.transparent,
            child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expandIconColor: Colors.transparent,
              dividerColor: Colors.transparent,
              // Callback for handling expansion and collapse of filter sections
              expansionCallback: (int index, bool isExpanded) {
                var animalType = AnimalType.values[index];

                setState(() {
                  isTypeCheckedMap[animalType] = !isExpanded;
                  if (!isExpanded) {
                    _selectedBreedsMap[animalType] = <dynamic>{};
                  }
                });
              },
              // Map AnimalType values to ExpansionPanel widgets
              children: AnimalType.values.map<ExpansionPanel>(
                (AnimalType animalType) {
                  return ExpansionPanel(
                    canTapOnHeader: false,
                    // Build the header of each ExpansionPanel
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(capitalize(
                                animalType.toString().split('.').last)),
                            const SizedBox(width: 10),
                            // Checkbox for each type
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

                                // Call the 'type' filter callback whenever the checkbox state changes
                                widget.onFilterOptionSelected('type',
                                    value == true ? selectedTypes : null);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    // Body of the ExpansionPanel with a list of breed checkboxes
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
          // Row for the 'Activity' filter dropdown
          Row(
            children: [
              const Text(
                'Activity:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // Dropdown button for selecting activity
              DropdownButton<AnimalActivity>(
                value: _selectedActivity,
                onChanged: (AnimalActivity? value) {
                  setState(() {
                    // Call filter callback and update selected activity
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
          // Row for the 'Sex' filter dropdown
          Row(
            children: [
              const Text(
                'Sex:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // Dropdown button for selecting sex
              DropdownButton<AnimalSex>(
                value: _selectedSex,
                onChanged: (AnimalSex? value) {
                  setState(() {
                    // Call filter callback and update selected sex
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
          // Display selected age range
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
          // Row for the 'Age' filter range slider
          Row(
            children: [
              const Text(
                'Age:   ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // Range slider for selecting age range
              RangeSlider(
                values: _selectedAge,
                onChanged: (RangeValues values) {
                  setState(() {
                    _selectedAge = values;
                  });
                  // Call filter callback and update selected age range
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
}
