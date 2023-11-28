import 'dart:async';

import 'package:adoption_app/models/adoption_center.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final AdoptionCenterLocation adoptionCenterLocation;

  MapScreen({super.key, required this.adoptionCenterLocation});

  @override
  State<MapScreen> createState() => MapState();
}

class MapState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(0, 0), // Default to (0, 0)
      zoom: 15,
    );
    _updateCameraPosition();
  }

  Future<void> _updateCameraPosition() async {
    await widget.adoptionCenterLocation.fetchCoordinates();

    setState(() {
      _initialCameraPosition = CameraPosition(
        target: widget.adoptionCenterLocation.coordinates,
        zoom: 15,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.adoptionCenterLocation.fetchCoordinates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {},
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: <Marker>{
                  Marker(
                    markerId: const MarkerId('adoptionCenter'),
                    position: widget.adoptionCenterLocation.coordinates,
                    infoWindow: const InfoWindow(
                      title: 'Adoption Center',
                      snippet: 'Your adoption center is here!',
                    ),
                  ),
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
