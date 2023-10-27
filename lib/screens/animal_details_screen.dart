import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;

  AnimalDetailScreen({super.key, required this.animal});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        onProfilePressed: () {},
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250, // Set the image container height
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
                      animal.name, // Display the animal's name
                      style: const TextStyle(
                        fontSize: 24, // Adjust the font size
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    const SizedBox(
                        width:
                            10), // Add spacing between the name and the button
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Adopt button press
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Square button
                        ),
                      ),
                      child: const Text("Adopt"),
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