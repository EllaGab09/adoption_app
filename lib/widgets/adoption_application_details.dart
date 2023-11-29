import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class AdoptionApplicationDetails extends StatelessWidget {
  //final AdoptionApplication adoptionApplication;
  final String userName;
  final String userMessage;
  final String adoptionCenter;
  final Animal animal;

  AdoptionApplicationDetails({
    super.key,
    required this.userName,
    required this.userMessage,
    required this.adoptionCenter,
    required this.animal,
  });

  //TODO fetch status
  var status = "Pending";

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Name: $userName',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'User Message: $userMessage',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Adoption Center: $adoptionCenter',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Application Status: $status',
                style: const TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 490,
                child: ListView(
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
                                  width:
                                      10), // Spacing between the name and the button
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
                          //Text(animal.location),
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
                                  // Text(
                                  //   'Type: ${animal.type}',
                                  //   style: const TextStyle(
                                  //     fontSize: 16,
                                  //   ),
                                  // ),
                                  const SizedBox(
                                      width:
                                          16), // Adjust the spacing between items
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
                                  const SizedBox(
                                      width:
                                          16), // Adjust the spacing between items
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
                              color: _getActivityLevelColor(
                                  animal.activityLevel.toString()),
                            ),
                          ),
                          ListTile(
                            title: const Text("Sex:"),
                            // subtitle: Text(animal.sex),
                            leading: Icon(
                              animal.sex.toString() == "Male"
                                  ? Icons.male
                                  : Icons.female,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
