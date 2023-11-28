import 'package:uuid/uuid.dart';

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

enum FishType { goldfish, betta, tetras, guppies, angelfish }

enum ReptileType { turtle, snake, lizard, frog }

enum RodentsType { rabbit, guineaPig, hamster, gerbils, mice, rat }

enum AnimalType { unspecified, dog, cat, bird, reptile, fish, rodent }

enum AnimalActivity { unspecified, low, medium, high }

enum AnimalSex { unspecified, male, female }

const uuid = Uuid();

class Animal {
  Animal(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.type,
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
  String type;
  final String breed;
  final int age;
  String activityLevel;
  String sex;
  final String health;
  final List<String>? applicationIds;

  bool availability = true;

  List<AnimalType> getAnimalTypes() {
    return AnimalType.values;
  }

  List<AnimalActivity> getActivityLevels() {
    return AnimalActivity.values;
  }

  List<AnimalSex> getSex() {
    return AnimalSex.values;
  }
  /*  const Animal({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.type,
    required this.breed,
    required this.age,
    required this.activityLevel,
    required this.sex,
  }); */
}
