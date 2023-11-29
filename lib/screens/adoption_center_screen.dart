import 'package:adoption_app/widgets/googleMap.dart';
import 'package:adoption_app/screens/add_animal_screen.dart';
import 'package:adoption_app/screens/adoption_application_details_user.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/adoption_center.dart';

// Screen for displaying details of an adoption center
class AdoptionCenterScreen extends StatelessWidget {
  final AdoptionCenter adoptionCenter; // Adoption center data to be displayed

  // Constructor to initialize the AdoptionCenterScreen widget with the required adoption center data
  AdoptionCenterScreen({super.key, required this.adoptionCenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(adoptionCenter
            .name), // Display the name of the adoption center in the app bar
      ),
      body: ListView(
        children: <Widget>[
          // Image Section
          const SizedBox(
            height: 250,
          ),
          // Button to add a new animal
          ElevatedButton(
            onPressed: () {
              // Navigate to the AddAnimalForm screen when the button is pressed
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      AddAnimalForm(key: key, adoptionCenter: adoptionCenter)));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Square button
              ),
            ),
            child: const Text("Add a new animal"),
          ),
          // Adoption Center Details Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description Section
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  adoptionCenter.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Contact Section
                const Text(
                  'Contact ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  adoptionCenter.phoneNo,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                // Interactive Map Section
                InkWell(
                  onTap: () {
                    // Navigate to the MapScreen when the map section is tapped
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MapScreen(
                          adoptionCenterLocation: adoptionCenter.location,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Click for interactive map"),
                    subtitle: Text(
                      '${adoptionCenter.location.street}, ${adoptionCenter.location.city}, ${adoptionCenter.location.zipCode}, ${adoptionCenter.location.country}',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Map Section
                SizedBox(
                  height: 300,
                  child: MapScreen(
                    adoptionCenterLocation: adoptionCenter.location,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
