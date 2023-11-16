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
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            dividerColor: Colors.grey,
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
            children:
                AnimalType.values.map<ExpansionPanel>((AnimalType animalType) {
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(animalType.toString().split('.').last),
                        SizedBox(width: 10),
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
                            widget.onFilterOptionSelected(
                                'breed', selectedBreedsMap.values.join(', '));
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: getBreedDropdownItems(animalType).length,
                  itemBuilder: (context, index) {
                    var breed = getBreedDropdownItems(animalType)[index];
                    return CheckboxListTile(
                      title: Text(breed.toString().split('.').last),
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
            }).toList(),
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
                value: AnimalActivity.unspecified,
                onChanged: (AnimalActivity? value) {
                  widget.onFilterOptionSelected(
                      'Activity', value?.toString() ?? '');
                },
                items: AnimalActivity.values
                    .map<DropdownMenuItem<AnimalActivity>>(
                        (AnimalActivity value) {
                  return DropdownMenuItem<AnimalActivity>(
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

  List<dynamic> getBreedDropdownItems(AnimalType animalType) {
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
}
