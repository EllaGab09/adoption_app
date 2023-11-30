import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Generate a unique identifier using the UUID package
const uuid = Uuid();

// Model representing an Adoption Center
class AdoptionCenter {
  AdoptionCenter({
    required this.name,
    required this.description,
    required this.phoneNo,
    required this.location,
    required this.email,
    required this.password,
    this.animalIds,
  }) : adoptionCenterId = uuid.v4();

  final String adoptionCenterId; // Unique identifier for the Adoption Center
  final String name;
  final String phoneNo;
  final String description;
  final AdoptionCenterLocation location;
  final String email;
  final String password;
  final String role = 'adoptionCenter';
  final List<String>?
      animalIds; // List of animal IDs associated with the center
}

// Model representing the location of an Adoption Center
class AdoptionCenterLocation {
  LatLng coordinates; // Geographic coordinates (latitude and longitude)
  final String street;
  final String city;
  final String zipCode;
  final String country;

  AdoptionCenterLocation({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  }) : coordinates = LatLng(0, 0); // Initialize coordinates to default (0, 0)

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'country': country,
    };
  } // Initialize coordinates to default (0, 0)

  // Fetch coordinates for the given address using the Google Maps Geocoding API
  Future<void> fetchCoordinates() async {
    const apiKey = 'AIzaSyCY2zMPRGHVKE11z-bGeHdclT9d5UuX38I';
    final address = '$street, $city, $zipCode, $country';
    final encodedAddress = Uri.encodeQueryComponent(address);
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        coordinates =
            LatLng(lat, lng); // Update coordinates with fetched values
      }
    } else {
      throw Exception('Failed to fetch coordinates');
    }
  }
}
