import 'package:uuid/uuid.dart';

const uuid = Uuid();

class AdoptionCenter {
  AdoptionCenter({
    //required this.imageUrl,
    required this.name,
    required this.description,
    required this.location,
    required this.email,
    required this.password,
    this.animalIds,
  }) : adoptionCenterId = uuid.v4();

  //final String imageUrl;
  final String adoptionCenterId;
  final String name;
  final String description;
  final AdoptionCenterLocation location;
  final String email;
  final String password;
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
