import 'package:adoption_app/widgets/googleMap.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdoptionCenterScreen extends StatelessWidget {
  final AdoptionCenter adoptionCenter;

  AdoptionCenterScreen({Key? key, required this.adoptionCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adoptionCenter.name),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            /* child: Image.network(
              adoptionCenter.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ), */
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
                          adoptionCenterLocation: adoptionCenter.adress,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Location"),
                    subtitle: Text(
                      '${adoptionCenter.adress.street}, ${adoptionCenter.adress.city}, ${adoptionCenter.adress.zipCode}, ${adoptionCenter.adress.country}',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // The adoptionCenterLocation is passed to MapScreen
                Container(
                  height: 300,
                  child: MapScreen(
                    adoptionCenterLocation: adoptionCenter.adress,
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
