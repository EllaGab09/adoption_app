import 'package:adoption_app/widgets/googleMapTest.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdoptionCenterScreen extends StatelessWidget {
  final AdoptionCenter adoptionCenter;
  final Set<Marker> markers;

  AdoptionCenterScreen({Key? key, required this.adoptionCenter})
      : markers = <Marker>{
          Marker(
            markerId: MarkerId(adoptionCenter.id),
            position: adoptionCenter.location.location,
            infoWindow: InfoWindow(
              title: adoptionCenter.name,
              snippet:
                  'Location: ${adoptionCenter.location.city}, ${adoptionCenter.location.country}',
            ),
          ),
        },
        super(key: key);

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
            child: Image.network(
              adoptionCenter.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => MapSample()));
                  },
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Location"),
                    subtitle: Text(
                      '${adoptionCenter.location.street}, ${adoptionCenter.location.city}, ${adoptionCenter.location.zipCode}, ${adoptionCenter.location.country}',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      height: 300, // Adjust the height as needed
                      child: MapSample(), // Embed the GoogleMapScreen here
                    ),
                  ],
                ),
                /* GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      adoptionCenter.location.location.latitude,
                      adoptionCenter.location.location.longitude,
                    ),
                    zoom: 15.0, // You can adjust the initial zoom level
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('adoption_center_location'),
                      position: LatLng(
                        adoptionCenter.location.location.latitude,
                        adoptionCenter.location.location.longitude,
                      ),
                      infoWindow: InfoWindow(
                        title: adoptionCenter.name,
                        snippet: adoptionCenter.location.street,
                      ),
                    ),
                  },
                ) */
              ],
            ),
          ),
        ],
      ),
    );
  }
}
