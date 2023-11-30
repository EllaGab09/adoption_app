import 'package:adoption_app/dummy_data/user_data.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/models/application.dart';
import 'package:adoption_app/screens/adoption_center_screen.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adoption_app/providers/applications_provider.dart';
import 'package:uuid/uuid.dart';

class AnimalDetailScreen extends ConsumerWidget {
  final Animal animal;
  final uuid = const Uuid();

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

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  /// Generates an application for adoption.
  ///
  /// This method takes a [BuildContext] and a [WidgetRef] as parameters.
  /// It is responsible for generating an application for adoption in the given [BuildContext] using the [WidgetRef].
  void generateApplication(BuildContext context, WidgetRef ref, Animal animal) {
    final newApplication = Application(
      userName: dummyUser.firstname,
      animalName: animal.name,
      message: _messageController.text,
    );

    ref.read(applicationProvider.notifier).addApplication(newApplication);
    _messageController.clear();
  }

  /// Shows a confirmation dialog.
  ///
  /// This method displays a confirmation dialog in the given [context].
  /// The [ref] parameter is a reference to the widget tree, which can be used
  /// to access dependencies and state.
  void showConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Application Submitted'),
          content: RichText(
            text: TextSpan(
              text: 'Your application to adopt ',
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: animal.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const TextSpan(
                    text:
                        ' has been submitted. You will be notified when your application is reviewed.',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows a dialog for adopting an animal.
  ///
  /// This method displays a dialog box for adopting an animal. It takes the [BuildContext] and [WidgetRef] as parameters.
  /// The [BuildContext] is used to show the dialog, while the [WidgetRef] is used to access dependencies.
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
                    return null;
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
                // Check for existing applications
                final existingApplications = ref.read(applicationProvider);
                final isDuplicateApplication = existingApplications.any(
                    (application) =>
                        application.userName == dummyUser.firstname &&
                        application.animalName == animal.name);

                if (isDuplicateApplication) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have already applied for ${animal.name}.',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  // Generate the application
                  generateApplication(context, ref, animal);
                  // Close the dialog
                  Navigator.of(context).pop();
                  // Show the confirmation dialog
                  showConfirmationDialog(context, ref);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override

  /// Builds the widget for the animal details screen.
  ///
  /// This method is responsible for constructing the UI for the animal details screen.
  /// It takes in the [BuildContext] and [WidgetRef] as parameters.
  /// Returns a [Widget] representing the constructed UI.
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAnimals = ref.watch(favoritesAnimalProvider);
    final isFavorite = favoriteAnimals.contains(animal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                      // Toggle the favorite status of the animal
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
                const SizedBox(
                  height: 10,
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
                          'Breed: ${capitalize(animal.breed)}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 55),
                          child: Text(
                            animal.health,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
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
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 45),
                          child: Text(
                            animal.availability ? "Available" : "Unavailable",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
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
