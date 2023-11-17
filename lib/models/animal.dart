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

enum SmallAnimals { rabbits, guineaPigs, hamsters, gerbils, mice, rats }

enum AnimalType { dog, cat, bird, reptile, fish, smallAnimals }

enum AnimalActivity { unspecified, low, medium, high }

enum AnimalSex { unspecified, male, female }

class Animal {
  final String name;
  final String imageUrl;
  final String description;
  final String type; //Dog, Cat, Bird etc
  final String breed;
  final int age;
  final String activityLevel;
  final String sex;
  final String location;

  const Animal({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.type,
    required this.breed,
    required this.age,
    required this.activityLevel,
    required this.sex,
    required this.location,
  });
}
