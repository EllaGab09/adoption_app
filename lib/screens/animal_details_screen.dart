import 'package:adoption_app/dummy_data/user_data.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/models/application.dart';
import 'package:adoption_app/screens/adoption_center_screen.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:adoption_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adoption_app/providers/applications_provider.dart';

class AnimalDetailScreen extends ConsumerWidget {
  final Animal animal;
  final TextEditingController _messageController = TextEditingController();

  AnimalDetailScreen({super.key, required this.animal});

  final dummyAdoptionCenter = AdoptionCenter(
    name: 'Happy Paws Adoption Center',
    description: 'We provide a loving home for pets of all kinds.',
    phoneNo: '123456789',
    location: AdoptionCenterLocation(
      street: 'Midtre Lambertgard',
      city: 'Langevåg',
      zipCode: '6030',
      country: 'Norge',
    ),
    email: 'test@email.com',
    password: "1234",
    animalIds: ['1', '2', '3'],
  );

  Color _getActivityLevelColor(String activityLevel) {
    if (activityLevel == "Low") {
      return Colors.green;
    } else if (activityLevel == "Medium") {
      return Colors.orange;
    } else if (activityLevel == "High") {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  void showAdoptionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Apply for Adoption'),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    '${dummyUser.firstname}, please enter a message to apply for adoption.'),
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your message',
                    errorStyle: TextStyle(color: Colors.redAccent),
                  ),
                  maxLines: null,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a message.';
                    }
                    Pattern pattern = r'^[A-Za-z0-9 ]+$';
                    RegExp regex = RegExp(pattern as String);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid message.';
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Adopt'),
              onPressed: () {
                final newApplication = Application(
                  id: DateTime.now().toString(),
                  userName: dummyUser.firstname,
                  message: _messageController.text,
                );
                ref
                    .read(applicationProvider.notifier)
                    .addApplication(newApplication);
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Application Submitted'),
                        content: Text(
                            'Your application to adopt ${animal.name} has been submitted. You will be notified when your application is reviewed.'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                _messageController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAnimals = ref.watch(favoritesAnimalProvider);
    final isFavorite = favoriteAnimals.contains(animal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 8,
        title:
            //  padding: const EdgeInsets.only(left: 1),
            Image.asset(
          'assets/images/petAdoptLogo.png',
          width: 240,
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Image.network(
              animal.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      animal.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        final wasAdded = ref
                            .read(favoritesAnimalProvider.notifier)
                            .toggleFavoriteAnimal(animal);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              wasAdded
                                  ? '${animal.name} was added to favorites.'
                                  : '${animal.name} was removed from favorites.',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.red,
                        key: ValueKey(isFavorite),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => AdoptionCenterScreen(
                                  adoptionCenter: dummyAdoptionCenter,
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text("Adoption Center"),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        showAdoptionDialog(context, ref);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text("Adopt"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  animal.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          'Breed: ${animal.breed}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          'Age: ${animal.age} years',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ListTile(
                  title: const Text("Activity Level"),
                  subtitle: Text(animal.activityLevel.toString()),
                  leading: Icon(
                    Icons.directions_run,
                    color:
                        _getActivityLevelColor(animal.activityLevel.toString()),
                  ),
                ),
                ListTile(
                  title: const Text("Sex:"),
                  subtitle: Text(animal.sex),
                  leading: Icon(
                    animal.sex == "Male" ? Icons.male : Icons.female,
                    color: animal.sex == "Male" ? Colors.blue : Colors.pink,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
