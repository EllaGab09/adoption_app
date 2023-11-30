import 'package:adoption_app/controllers/animal_controller.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

class AddAnimalForm extends StatefulWidget {
  final AdoptionCenter adoptionCenter;
  Animal animal = Animal(
      name: "",
      imageUrl: "",
      description: "",
      type: "",
      breed: "",
      age: 0,
      activityLevel: "",
      sex: "",
      health: "",
      applicationIds: [],
      availability: true);

  AddAnimalForm({super.key, required this.adoptionCenter});

  @override
  _AddAnimalFormState createState() => _AddAnimalFormState();
}

class _AddAnimalFormState extends State<AddAnimalForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();

  bool showBreedDropdown = false;

  AnimalType animalType = AnimalType.unspecified;
  AnimalSex animalSex = AnimalSex.unspecified;
  AnimalActivity activityLevel = AnimalActivity.unspecified;

  // Map of breed options for each animal type
  final Map<AnimalType, List<String>> breedOptions = {
    AnimalType.dog: DogBreed.values
        .map((breed) => breed.toString().split('.').last)
        .toList(),
    AnimalType.cat: CatBreed.values
        .map((breed) => breed.toString().split('.').last)
        .toList(),
    AnimalType.bird: BirdBreed.values
        .map((breed) => breed.toString().split('.').last)
        .toList(),
    AnimalType.reptile: ReptileType.values
        .map((breed) => breed.toString().split('.').last)
        .toList(),
    AnimalType.fish: FishType.values
        .map((breed) => breed.toString().split('.').last)
        .toList(),
    AnimalType.rodent: RodentsType.values
        .map((breed) => breed.toString().split('.').last)
        .toList(),
  };

// Set the selected animal type
  void _setAnimalType(AnimalType value) {
    setState(() {
      animalType = AnimalType.values.firstWhere((type) => type == value);
      showBreedDropdown = true;
    });
  }

  // Set the selected activity level
  void _setAnimalActivityLevel(AnimalActivity value) {
    setState(() {
      activityLevel = AnimalActivity.values.firstWhere((type) => type == value);
    });
  }

  // Set the selected animal sex
  void _setAnimalSex(AnimalSex value) {
    setState(() {
      animalSex = AnimalSex.values.firstWhere((type) => type == value);
    });
  }

  // Handle the form submission
  void onPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Create a new Animal object with form values
      widget.animal = Animal(
          name: capitalize(_nameController.text),
          imageUrl: _imageURLController.text,
          description: capitalize(_descriptionController.text),
          type: capitalize(animalType.toString().split('.').last),
          breed: _typeController.text,
          age: int.parse(_ageController.text),
          activityLevel: capitalize(activityLevel.toString().split('.').last),
          sex: capitalize(animalSex.toString().split('.').last),
          health: capitalize(_healthController.text),
          applicationIds: [],
          availability: true);

      // Clear form fields
      _nameController.clear();
      _imageURLController.clear();
      _descriptionController.clear();
      _typeController.clear();
      _ageController.clear();
      _healthController.clear();

      try {
        // Call the addAnimal method in the AnimalController
        await AnimalController.addAnimal(animal: widget.animal);
      } catch (e) {
        // Show a snackbar if animal addition fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Animal could not be added'),
          ),
        );
      }
    } else {
      // Show a snackbar if form validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid fields'),
        ),
      );
    }
  }

  // Capitalize the first letter of a string
  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.adoptionCenter.name),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text('Add Animal',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          )),
                ),

                // NAME
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    errorStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),

                // IMAGE URL
                TextFormField(
                  controller: _imageURLController,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    errorStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                ),

                // DESCRIPTION
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    errorStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                // HEALTH
                TextFormField(
                  controller: _healthController,
                  decoration: InputDecoration(
                    labelText: 'Health',
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    errorStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the health of the animal';
                    }
                    return null;
                  },
                ),

                // ANIMAL TYPE
                DropdownButton<AnimalType>(
                  value: animalType,
                  onChanged: (AnimalType? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _setAnimalType(newValue);
                        _typeController.text =
                            breedOptions[newValue]?.first ?? "";
                      });
                    }
                  },
                  items: AnimalType.values
                      .map<DropdownMenuItem<AnimalType>>((AnimalType value) {
                    return DropdownMenuItem<AnimalType>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),

                // BREED
                DropdownButtonFormField<String>(
                  value: (animalType != AnimalType.unspecified)
                      ? breedOptions[animalType]?.first ?? ""
                      : "",
                  onChanged: (String? newValue) {
                    setState(() {
                      _typeController.text = newValue ?? '';
                    });
                  },
                  items: (animalType == AnimalType.unspecified)
                      ? [
                          const DropdownMenuItem(
                            value: "",
                            child: Text("Select Type First"),
                          ),
                        ]
                      : breedOptions[animalType]?.map<DropdownMenuItem<String>>(
                            (String breed) {
                              return DropdownMenuItem<String>(
                                value: breed,
                                child: Text(breed),
                              );
                            },
                          ).toList() ??
                          [],
                  decoration: InputDecoration(
                    labelText: 'Breed',
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    errorStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a breed';
                    }
                    return null;
                  },
                ),

                // ACTIVITY LEVEL
                DropdownButton<AnimalActivity>(
                  value: activityLevel,
                  onChanged: (AnimalActivity? newValue) {
                    if (newValue != null) {
                      _setAnimalActivityLevel(newValue);
                    }
                  },
                  items: AnimalActivity.values
                      .map<DropdownMenuItem<AnimalActivity>>(
                          (AnimalActivity value) {
                    return DropdownMenuItem<AnimalActivity>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),

                // ANIMAL SEX
                DropdownButton<AnimalSex>(
                  value: animalSex,
                  onChanged: (AnimalSex? newValue) {
                    if (newValue != null) {
                      _setAnimalSex(newValue);
                    }
                  },
                  items: AnimalSex.values
                      .map<DropdownMenuItem<AnimalSex>>((AnimalSex value) {
                    return DropdownMenuItem<AnimalSex>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),

                // AGE
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    errorStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 1 ||
                        int.parse(value) > 25) {
                      return 'Please enter an age between 1 and 25';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    onPressed(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
