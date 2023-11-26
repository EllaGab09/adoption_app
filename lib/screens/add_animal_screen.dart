import 'package:adoption_app/dummy_data/user_data.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:adoption_app/screens/user_profile_screen.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
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
      type: "",
      breed: "",
      color: "",
      age: 0,
      activityLevel: "",
      sex: "",
      location: "");

  AddAnimalForm({super.key, required this.adoptionCenter});

  void onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      animal = Animal(
          name: _nameController.text,
          imageUrl: _imageURLController.text,
          description: _descriptionController.text,
          type: _typeController.text,
          color: _colorController.text,
          breed: _breedController.text,
          age: int.parse(_ageController.text),
          activityLevel: _activityLevelController.text,
          sex: _sexController.text,
          location: _locationController.text);

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
      appBar: LogoAppBar(
        onProfilePressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(user: dummyUser),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Add Animal',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
