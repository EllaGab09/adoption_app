import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class AdoptionCenter {
  final String id;
  //final String imageUrl;
  final String name;
  final String description;
  final String phoneNo;
  final AdoptionCenterLocation adress;
  final List<String> availableAnimalIds;

  AdoptionCenter({
    required this.id,
    //required this.imageUrl,
    required this.name,
    required this.description,
    required this.phoneNo,
    required this.adress,
    required this.availableAnimalIds,
  });
}

class AdoptionCenterLocation {
  LatLng coordinates;
  final String street;
  final String city;
  final String zipCode;
  final String country;

  AdoptionCenterLocation({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  }) : coordinates = LatLng(0, 0);

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
        coordinates = LatLng(lat, lng);
      }
    } else {
      throw Exception('Failed to fetch coordinates');
    }
  }
}
