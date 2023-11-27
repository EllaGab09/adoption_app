import 'package:adoption_app/models/adoption_center.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

// TODO: change breed to dropdown
// TODO: make age a number input and limit to 0-18

class AddAnimalForm extends StatefulWidget {
  final AdoptionCenter adoptionCenter;
  Animal animal = Animal(
      name: "",
      imageUrl: "",
      description: "",
      animalType: AnimalType.cat,
      breed: "",
      age: 0,
      activityLevel: ActivityLevel.high,
      sex: Sex.female,
      health: "",
      applicationIds: [],
      availability: true);

  AddAnimalForm({super.key, required this.adoptionCenter});

  @override
  _AddAnimalFormState createState() => _AddAnimalFormState();
}

class _AddAnimalFormState extends State<AddAnimalForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Dropdown values set to an inital default value
  AnimalType animalType = AnimalType.cat;
  Sex animalSex = Sex.female;
  ActivityLevel activityLevel = ActivityLevel.high;

  void _setAnimalType(AnimalType value) {
    setState(() {
      animalType = AnimalType.values.firstWhere((type) => type == value);
    });
  }

  void _setAnimalActivityLevel(ActivityLevel value) {
    setState(() {
      activityLevel = ActivityLevel.values.firstWhere((type) => type == value);
    });
  }

  void _setAnimalSex(Sex value) {
    setState(() {
      animalSex = Sex.values.firstWhere((type) => type == value);
    });
  }

  void onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      widget.animal = Animal(
          name: _nameController.text,
          imageUrl: _imageURLController.text,
          description: _descriptionController.text,
          animalType: animalType,
          breed: _breedController.text,
          age: int.parse(_ageController.text),
          activityLevel: ActivityLevel.high, // TODO change to dropdown
          sex: animalSex,
          health: "",
          applicationIds: [],
          availability: true);

      _nameController.clear();
      _imageURLController.clear();
      _descriptionController.clear();
      _typeController.clear();
      _breedController.clear();
      _ageController.clear();
      _activityLevelController.clear();
      _sexController.clear();
      _locationController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pet added to the portfolio'),
        ),
      );
    }

    // TODO: Replace the print statement with crud operation

    debugPrint("Name: " +
        widget.animal!.name +
        ", Age: " +
        (widget.animal!.age).toString() +
        ", Breed: " +
        widget.animal!.breed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.adoptionCenter.name),
      ),
      body: Padding(
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
                  // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
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
                  // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
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
                  // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
                  errorStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageURLController,
                decoration: InputDecoration(
                  labelText: 'Image URL', // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
                  errorStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a image URL';
                  }
                  return null;
                },
              ),
              // DESCRIPTION
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description', // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
                  errorStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              // ANIMAL TYPE
              DropdownButton<AnimalType>(
                value: animalType,
                onChanged: (AnimalType? newValue) {
                  if (newValue != null) {
                    _setAnimalType(newValue);
                  }
                },
                items: widget.animal!
                    .getAnimalTypes()
                    .map<DropdownMenuItem<AnimalType>>((AnimalType value) {
                  return DropdownMenuItem<AnimalType>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              DropdownButton<ActivityLevel>(
                value: activityLevel,
                onChanged: (ActivityLevel? newValue) {
                  if (newValue != null) {
                    _setAnimalActivityLevel(newValue);
                  }
                },
                items: widget.animal!
                    .getActivityLevels()
                    .map<DropdownMenuItem<ActivityLevel>>(
                        (ActivityLevel value) {
                  return DropdownMenuItem<ActivityLevel>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              // ANIMAL SEX
              DropdownButton<Sex>(
                value: animalSex,
                onChanged: (Sex? newValue) {
                  if (newValue != null) {
                    _setAnimalSex(newValue);
                  }
                },
                items: widget.animal!
                    .getSex()
                    .map<DropdownMenuItem<Sex>>((Sex value) {
                  return DropdownMenuItem<Sex>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              // BREED
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(
                  labelText: 'Breed', // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
                  errorStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a breed';
                  }
                  return null;
                },
              ),
              // AGE
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age', // Apply theme style for input field
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  // Apply theme style for error text
                  errorStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
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
    );
  }
}
