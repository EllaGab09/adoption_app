import 'package:adoption_app/models/adoption_center.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

class AddAnimalForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final AdoptionCenter adoptionCenter;

  // Animal object to be saved in database
  Animal animal = Animal(
      name: "",
      imageUrl: "",
      description: "",
      animalType: AnimalType.cat,
      breed: "",
      color: "",
      age: 0,
      sex: Sex.male,
      activityLevel: "",
      health: "",
      applicationIds: [],
      availability: true);

  AddAnimalForm({super.key, required this.adoptionCenter});

  void onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      animal = Animal(
          name: _nameController.text,
          imageUrl: _imageURLController.text,
          description: _descriptionController.text,
          animalType: AnimalType.cat, // TODO: change to controller
          color: _colorController.text,
          breed: _breedController.text,
          age: int.parse(_ageController.text),
          activityLevel: _activityLevelController.text,
          sex: Sex.female, //TODO: change to enum
          health: "",
          applicationIds: [],
          availability: true);

      _nameController.clear();
      _imageURLController.clear();
      _descriptionController.clear();
      _typeController.clear();
      _colorController.clear();
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
        animal.name +
        ", Age: " +
        (animal.age).toString() +
        ", Breed: " +
        animal.breed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adoptionCenter.name),
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageURLController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(labelText: 'Breed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a breed';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
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
