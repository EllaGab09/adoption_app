import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdoptionCenter {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final AdoptionCenterLocation location;
  final List<String> availableAnimalIds;

  AdoptionCenter({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.location,
    required this.availableAnimalIds,
  });
}

class AdoptionCenterLocation {
  final LatLng location;
  final String street;
  final String city;
  final String zipCode;
  final String country;

  AdoptionCenterLocation({
    required this.location,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  });
}
