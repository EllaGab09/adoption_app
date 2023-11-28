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
  Map<AnimalType, Set<String>> _selectedBreedsMap = {};
  Map<AnimalType, bool> isTypeCheckedMap = {};

  // Selected activity, sex, age, and types
  AnimalActivity _selectedActivity = AnimalActivity.unspecified;
  AnimalSex _selectedSex = AnimalSex.unspecified;
  late List<AnimalType> _selectedTypes;
  late RangeValues _selectedAge;
  Set<String> _selectedBreeds = {};

  // Function to capitalize the first letter of a string
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
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
    } else if (RodentsType.values.map((e) => e.toString()).contains(breed)) {
      return AnimalType.rodent;
    } else {
      return AnimalType.dog;
    }
  }

  // Initialize state with selected filter options
  @override
  void initState() {
    super.initState();
    _selectedActivity = widget.selectedActivity;
    _selectedSex = widget.selectedSex;
    _selectedAge = widget.selectedAge;
    _selectedTypes = widget.selectedTypes;

    // Initialize isTypeCheckedMap with the selected types
    isTypeCheckedMap = _selectedTypes.asMap().map((index, type) {
      return MapEntry(type, true);
    });

    // Initialize _selectedBreedsMap with the selected breeds
    _selectedBreedsMap = {};
    for (var type in AnimalType.values) {
      if (_selectedTypes.contains(type)) {
        _selectedBreedsMap[type] = {};
      }
    }

    for (var breed in widget.selectedBreeds) {
      var type = getBreedType(breed);
      if (_selectedBreedsMap.containsKey(type)) {
        _selectedBreedsMap[type]!.add(breed);
      }
    }

    // Ensure that selected breeds are added to _selectedBreedsMap
    _selectedBreedsMap.forEach((type, breeds) {
      _selectedBreeds.addAll(breeds);
    });
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
      case AnimalType.rodent:
        return RodentsType.values;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Drawer(
        width: 170,
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: CustomScrollView(slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 50.0,
              backgroundColor: Colors.white,
              flexibleSpace: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10), // Adjust left padding
                    child: Text(
                      'Filters',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      widget.onFilterOptionSelected('resetFilters', null);
                      setState(() {
                        _selectedActivity = AnimalActivity.unspecified;
                        _selectedSex = AnimalSex.unspecified;
                        _selectedAge = const RangeValues(0, 15);
                        _selectedTypes = [];
                        _selectedBreeds = {};
                        isTypeCheckedMap = {
                          for (var type in AnimalType.values)
                            type: widget.selectedTypes.contains(type)
                        };
                        _selectedBreedsMap = {};
                        for (var type in AnimalType.values) {
                          isTypeCheckedMap[type] = false;
                        }
                      });
                    },
                    icon: const Column(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.restart_alt,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    tooltip: 'Reset Filters',
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
                            _selectedBreedsMap[animalType] = <String>{};
                          }
                        });
                      },
                      // Map AnimalType values to ExpansionPanel widgets
                      children: AnimalType.values
                          .where((type) =>
                              type !=
                              AnimalType
                                  .unspecified) // Filter out unspecified type
                          .map<ExpansionPanel>(
                        (AnimalType animalType) {
                          return ExpansionPanel(
                            canTapOnHeader: false,
                            // Build the header of each ExpansionPanel
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0), // Adjust vertical padding
                                title: Row(
                                  children: [
                                    // Checkbox for each type
                                    Checkbox(
                                      value:
                                          _selectedTypes.contains(animalType),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            // Update selectedTypes when the checkbox is checked
                                            _selectedTypes.add(animalType);
                                          } else {
                                            // Uncheck the checkbox and remove the type from selectedTypes
                                            _selectedTypes.remove(animalType);
                                          }
                                          isTypeCheckedMap[animalType] = value;
                                        });

                                        // Call the 'type' filter callback whenever the checkbox state changes
                                        widget.onFilterOptionSelected(
                                            'type',
                                            value == true
                                                ? _selectedTypes
                                                : null);
                                      },
                                    ),
                                    Text(capitalize(
                                        animalType.toString().split('.').last)),
                                  ],
                                ),
                              );
                            },
                            // Body of the ExpansionPanel with a list of breed checkboxes
                            body: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  getBreedDropdownItems(animalType).length,
                              itemBuilder: (context, index) {
                                var breed =
                                    getBreedDropdownItems(animalType)[index];
                                return BreedCheckbox(
                                  breed: breed.toString(),
                                  selectedBreeds: widget.selectedBreeds,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        widget.onFilterOptionSelected(
                                            'breed', breed.toString());
                                      } else {
                                        widget.onFilterOptionSelected(
                                            'breed', null);
                                      }
                                    });
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
                            _selectedActivity =
                                value ?? AnimalActivity.unspecified;
                          });
                        },
                        items: AnimalActivity.values
                            .map<DropdownMenuItem<AnimalActivity>>(
                                (AnimalActivity value) {
                          return DropdownMenuItem<AnimalActivity>(
                            value: value,
                            child: Text(
                                capitalize(value.toString().split('.').last)),
                          );
                        }).toList(),
                      ),
                      const Text(
                        ':Activity',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Row for the 'Sex' filter dropdown
                  Row(
                    children: [
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
                            .map<DropdownMenuItem<AnimalSex>>(
                                (AnimalSex value) {
                          return DropdownMenuItem<AnimalSex>(
                            value: value,
                            child: Text(
                                capitalize(value.toString().split('.').last)),
                          );
                        }).toList(),
                      ),
                      const Text(
                        ':Sex',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Display selected age range
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        (_selectedAge.start == _selectedAge.end)
                            ? 'Filtering: Only ${_selectedAge.start.round()}'
                            : (_selectedAge.start == 0 &&
                                    _selectedAge.end == 15)
                                ? 'Filtering: All ages'
                                : (_selectedAge.start == 0)
                                    ? 'Filtering:  Up to ${_selectedAge.end.round()}'
                                    : (_selectedAge.end == 15)
                                        ? 'Filtering:  From ${_selectedAge.start.round()} and up'
                                        : 'Filtering:  Between ${_selectedAge.start.round()} and ${_selectedAge.end.round()}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  // Row for the 'Age' filter range slider
                  Row(
                    children: [
                      const Text(
                        '  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      // Range slider for selecting age range
                      SizedBox(
                        width: 160,
                        child: RangeSlider(
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
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}

class BreedCheckbox extends StatefulWidget {
  final String breed;
  final Set<String> selectedBreeds;
  final ValueChanged<bool?> onChanged;

  const BreedCheckbox({
    super.key,
    required this.breed,
    required this.selectedBreeds,
    required this.onChanged,
  });

  @override
  _BreedCheckboxState createState() => _BreedCheckboxState();

  // Define the capitalize method within the BreedCheckbox class
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}

class _BreedCheckboxState extends State<BreedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      title: Text(widget.capitalize(widget.breed.toString().split('.').last)),
      contentPadding: EdgeInsets.zero,
      value: widget.selectedBreeds.contains(widget.breed
          .toString()
          .split('.')
          .last
          .toLowerCase()
          .replaceAll('}', '')),
      onChanged: widget.onChanged,
    );
  }
}
