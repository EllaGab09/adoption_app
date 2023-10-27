class User {
  final String id;
  final String imageUrl;
  final String username;
  final String email;
  final String password;
  final int age;
  final UserAddress address;

  User(
      {required this.id,
      required this.imageUrl,
      required this.username,
      required this.email,
      required this.password,
      required this.age,
      required this.address});
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
