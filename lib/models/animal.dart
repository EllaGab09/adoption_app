import 'package:uuid/uuid.dart';

enum AnimalType { cat, dog, bird, rodent }

enum Sex { male, female }

final uuid = Uuid();

class Animal {
  Animal(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.animalType,
      required this.breed,
      required this.color,
      required this.age,
      required this.activityLevel,
      required this.sex,
      required this.health,
      required this.availability,
      this.applicationIds})
      : animalId = uuid.v4();

  final String animalId;
  final String name;
  final String imageUrl;
  final String description;
  final AnimalType animalType;
  final String breed;
  final String color;
  final int age;
  final String activityLevel;
  final Sex sex;
  final String health;
  final List<String>? applicationIds;
  bool availability = true;
}
