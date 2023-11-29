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
import 'package:uuid/uuid.dart';

class AnimalDetailScreen extends ConsumerWidget {
  final Animal animal;
  final uuid = const Uuid();

  final TextEditingController _messageController = TextEditingController();

  AnimalDetailScreen({super.key, required this.animal});

  //Temp Dummy
  final dummyAdoptionCenter = AdoptionCenter(
    id: '1',
    imageUrl:
        "https://nebulae-assets.s3.amazonaws.com/3b56d17152bd46c295797a7eaab1f244.jpg",
    name: 'Happy Paws Adoption Center',
    description: 'We provide a loving home for pets of all kinds.',
    location: AdoptionCenterLocation(
      location:
          const LatLng(37.7749, -122.4194), // Replace with actual coordinates
      street: '123 Main St',
      city: 'Anytown',
      zipCode: '12345',
      country: 'United States',
    ),
    availableAnimalIds: ['1', '2', '3'], // Replace with actual animal IDs
  );

  Color _getActivityLevelColor(String activityLevel) {
    if (activityLevel == "Low") {
      return Colors.green;
    } else if (activityLevel == "Moderate") {
      return Colors.yellow;
    } else if (activityLevel == "High") {
      return Colors.red;
    } else {
      // Default color if the activity level is not recognized
      return Colors.grey;
    }
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
                ;
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
      appBar: LogoAppBar(actions: [
        IconButton(
          iconSize: 40,
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
            color: isFavorite ? Colors.red : Colors.white,
            key: ValueKey(isFavorite),
          ),
        ),
      ]),
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
                    const SizedBox(
                        width: 10), // Spacing between the name and the button
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showAdoptionDialog(context, ref);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Square button
                        ),
                      ),
                      child: const Text("Adopt"),
                    ),

                    //TEMP BUTTON
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => AdoptionCenterScreen(
                                  adoptionCenter: dummyAdoptionCenter,
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Square button
                        ),
                      ),
                      child: const Text("Adoption Center"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(animal.location),
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
                        Text(
                          'Type: ${animal.type}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Adjust the spacing between items
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
                        Text(
                          'Color: ${animal.color}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Adjust the spacing between items
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
                  subtitle: Text(animal.activityLevel),
                  leading: Icon(
                    Icons.directions_run,
                    color: _getActivityLevelColor(animal.activityLevel),
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
