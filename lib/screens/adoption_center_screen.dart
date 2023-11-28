import 'package:adoption_app/widgets/googleMap.dart';
import 'package:adoption_app/screens/add_animal_screen.dart';
import 'package:adoption_app/screens/adoption_application_details_user.dart';
import 'package:adoption_app/widgets/googleMap.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/adoption_center.dart';

import '../dummy_data/animal_data.dart';

class AdoptionCenterScreen extends StatelessWidget {
  final AdoptionCenter adoptionCenter;

  AdoptionCenterScreen({super.key, required this.adoptionCenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(adoptionCenter.name),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 250,
            /* child: Image.network(
              adoptionCenter.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ), */
          ),
          ElevatedButton(
            onPressed: () {
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                InkWell(
                  onTap: () {
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
                // The adoptionCenterLocation is passed to MapScreen
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
