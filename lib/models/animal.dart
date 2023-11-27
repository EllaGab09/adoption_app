import 'package:uuid/uuid.dart';

enum AnimalType { cat, dog, bird, rodent }

enum Sex { male, female }

enum ActivityLevel { low, medium, high }

const uuid = Uuid();

class Animal {
  Animal(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.animalType,
      required this.breed,
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
  AnimalType animalType;
  final String breed;
  final int age;
  ActivityLevel activityLevel;
  Sex sex;
  final String health;
  final List<String>? applicationIds;
  bool availability = true;

  List<AnimalType> getAnimalTypes() {
    return AnimalType.values;
  }

  List<ActivityLevel> getActivityLevels() {
    return ActivityLevel.values;
  }

  List<Sex> getSex() {
    return Sex.values;
  }
}
