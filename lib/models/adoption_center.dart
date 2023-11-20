import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final uuid = Uuid();

class AdoptionCenter {
  AdoptionCenter({
    //required this.imageUrl,
    required this.name,
    required this.description,
    required this.location,
    this.animalIds,
  }) : adoptionCenterId = uuid.v4();

  //final String imageUrl;
  final String adoptionCenterId;
  final String name;
  final String description;
  final AdoptionCenterLocation location;
  final List<String>? animalIds;
}

class AdoptionCenterLocation {
  final String street;
  final String city;
  final String zipCode;
  final String country;

  AdoptionCenterLocation({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  });
}
