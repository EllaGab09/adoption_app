import 'package:uuid/uuid.dart';

const uuid = Uuid();

// Model representing a user in the adoption application system
class Adopter {
  final String userId; // Unique identifier for the user
  final String firstname; // First name of the user
  final String surname; // Last name of the user
  final String email; // Email address of the user
  final String password; // Password associated with the user's account
  final int age; // Age of the user
  final UserAddress address; // Address information of the user
  final String role = "adopter"; // Role of the user
  final List<String>?
      applicationIds; // List of application IDs associated with the user

  Adopter({
    //required this.imageUrl,
    required this.firstname,
    required this.surname,
    required this.email,
    required this.password,
    required this.age,
    required this.address,
    this.applicationIds,
  }) : userId = uuid.v4(); // Generate a unique user ID using the Uuid library
}

// Model representing the address of a user
class UserAddress {
  final String street; // Street address
  final String city;
  final String zipCode;
  final String country;

  // Constructor to initialize the user address with required parameters
  UserAddress({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  });
  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'country': country,
    };
  }
}
