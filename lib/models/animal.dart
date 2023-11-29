import 'package:uuid/uuid.dart';

// Enumeration of dog breeds
enum DogBreed {
  labradorRetriever,
  germanShepherd,
  goldenRetriever,
  bulldog,
  beagle,
  poodle,
  rottweiler,
  siberianHusky,
  dachshund,
  boxer
}

// Enumeration of cat breeds
enum CatBreed {
  persian,
  siamese,
  maine,
  bengal,
  ragdoll,
  sphynx,
  abyssinian,
  scottishFold,
  surmese,
  britishShorthair
}

// Enumeration of bird breeds
enum BirdBreed {
  budgerigar,
  cockatiel,
  lovebird,
  parrot,
  cockatoo,
  conure,
  finch,
  canary,
  parakeet
}

// Enumeration of fish types
enum FishType { goldfish, betta, tetras, guppies, angelfish }

// Enumeration of reptile types
enum ReptileType { turtle, snake, lizard, frog }

// Enumeration of rodent types
enum RodentsType { rabbit, guineaPig, hamster, gerbils, mice, rat }

// Enumeration of animal types
enum AnimalType { unspecified, dog, cat, bird, reptile, fish, rodent }

// Enumeration of animal activity levels
enum AnimalActivity { unspecified, low, medium, high }

// Enumeration of animal sexes
enum AnimalSex { unspecified, male, female }

// Generate a unique identifier using the UUID package
const uuid = Uuid();

// Model representing an Animal
class Animal {
  Animal({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.type,
    required this.breed,
    required this.age,
    required this.activityLevel,
    required this.sex,
    required this.health,
    required this.availability,
    this.applicationIds,
  }) : animalId = uuid.v4();

  final String animalId; // Unique identifier for the Animal
  final String name;
  final String imageUrl;
  final String description;
  String
      type; // Note: 'type' can be modified, consider if 'AnimalType' enum should be used
  final String breed;
  final int age;
  String activityLevel;
  String sex;
  final String health;
  final List<String>?
      applicationIds; // List of application IDs associated with the animal

  bool availability = true; // Indicates if the animal is available for adoption

  // Get a list of available animal types
  List<AnimalType> getAnimalTypes() {
    return AnimalType.values;
  }

  // Get a list of available animal activity levels
  List<AnimalActivity> getActivityLevels() {
    return AnimalActivity.values;
  }

  // Get a list of available animal sexes
  List<AnimalSex> getSex() {
    return AnimalSex.values;
  }
}
