import 'package:google_maps_flutter/google_maps_flutter.dart';

class Animal {
  final String name;
  final String imageUrl;
  final String description;
  final String type; //Dog, Cat, Bird etc
  final String breed;
  final String color;
  final int age;
  final String activity_level;
  final LatLng location;

  Animal({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.type,
    required this.breed,
    required this.color,
    required this.age,
    required this.activity_level,
    required this.location,
  });
}
