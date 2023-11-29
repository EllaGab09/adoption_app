import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Adopter {
  Adopter({
    //required this.imageUrl,
    required this.firstname,
    required this.surname,
    required this.email,
    required this.password,
    required this.age,
    required this.address,
    this.applicationIds,
  }) : userId = uuid.v4();

  final String userId;
  //final String imageUrl;
  final String firstname;
  final String surname;
  final String email;
  final String password;
  final int age;
  final UserAddress address;
  final List<String>? applicationIds;
}

class UserAddress {
  final String street;
  final String city;
  final String zipCode;
  final String country;

  UserAddress({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  });
}
