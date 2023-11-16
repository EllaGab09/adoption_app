enum DogBreed { labrador, goldenRetriever, poodle }

enum CatBreed { siamese, persian }

enum BirdBreed { canary, parrot }

enum AnimalType { dog, cat, bird }

enum AnimalActivity { unspecified, low, medium, high }

enum AnimalSex { unspecified, male, female, high }

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
