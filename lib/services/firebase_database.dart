import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/models/adoption_center.dart';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _adoptionCenters = _db.collection('adoption_centers');
final CollectionReference _animals = _db.collection('animals');

class FirebaseCrud {
  static Future<Response> addAdoptionCenter({
    required String name,
    required String description,
    required AdoptionCenterLocation location,
    required List<String>? animalIds,
  }) async {
    Response response = Response();
    DocumentReference adoptionCenterDocumentReferencer = _adoptionCenters.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "adoption_center_name": name,
      "adoption_center_description": description,
      "adoption_center_address": location,
      "adoption_center_animals": animalIds
    };

    var result =
        await adoptionCenterDocumentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  static Future<Response> addAnimal({
    required Animal animal,
    required DocumentReference adoptionCenterDocumentReferencer,
  }) async {
    Response response = Response();
    DocumentReference animalDocumentReferencer = _animals.doc();

    // Set data for the animal
    var animalResult = await animalDocumentReferencer.set({
      "animalId": animal.animalId, // Include the animalId in the document
      "animal_name": animal.name,
      "animal_description": animal.description,
      "animal_type": animal.animalType,
      "animal_breed": animal.breed,
      "animal_color": animal.age,
      "animal_activity_level": animal.activityLevel,
      "animal_sex": animal.sex,
      "animal_availability": animal.availability
    }).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added animal to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    if (response.code != 200) {
      // If there was an error adding the animal, return the response
      return response;
    }

    // Get the ID of the newly added animal
    String animalId = animal.animalId;

    // Update the adoption center document with the new animal ID
    var adoptionCenterResult = await adoptionCenterDocumentReferencer.update({
      "animalIds": FieldValue.arrayUnion([animalId]),
    }).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added animal to the adoption center";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    if (response.code != 200) {
      // If there was an error updating the adoption center, return the response
      return response;
    }

    return response;
  }
}
