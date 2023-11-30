import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:adoption_app/models/animal.dart';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

final CollectionReference _animals = _db.collection('animals');

class AnimalController {
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
      "animal_type": animal.type,
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

  static Stream<QuerySnapshot> readAnimals() {
    CollectionReference notesItemCollection = _animals;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateAnimal({required Animal animal}) async {
    Response response = Response();
    DocumentReference animalDocumentReferencer = _animals.doc();

    var animalResult = await animalDocumentReferencer.update({
      "animalId": animal.animalId, // Include the animalId in the document
      "animal_name": animal.name,
      "animal_description": animal.description,
      "animal_type": animal.type,
      "animal_breed": animal.breed,
      "animal_color": animal.age,
      "animal_activity_level": animal.activityLevel,
      "animal_sex": animal.sex,
      "animal_availability": animal.availability,
      "animal_id": animal.animalId
    }).whenComplete(() {
      response.code = 200;
      response.message = "Successfully updated animal";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    if (response.code != 200) {
      // If there was an error adding the animal, return the response
      return response;
    }
    return response;
  }
}
