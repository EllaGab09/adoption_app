import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:adoption_app/models/animal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

final CollectionReference _animals = _db.collection('animals');

final CollectionReference _adoptionCenters = _db.collection('adoption_centers');

var currentUserId = FirebaseAuth
    .instance.currentUser?.uid; // Retrieve the user ID on tab change

class AnimalController {
  static Future<Response> addAnimal({
    required Animal animal,
  }) async {
    Response response = Response();
    DocumentReference animalDocumentReferencer = _animals.doc();

    // Set data for the animal
    Map<String, dynamic> animalData = <String, dynamic>{
      "animalId": animalDocumentReferencer.id, // Use the generated animalId
      "name": animal.name ?? "",
      "imageUrl": animal.imageUrl ?? "",
      "description": animal.description ?? "",
      "type": animal.type ?? "",
      "breed": animal.breed ?? "",
      "age": animal.age ?? "",
      "health": animal.health ?? "",
      "activityLevel": animal.activityLevel ?? "",
      "sex": animal.sex ?? "",
      "availability": animal.availability ?? "",
      "adoptionCenterId": currentUserId,
    };

    try {
      await animalDocumentReferencer.set(animalData);
      response.code = 200;
      response.message = "Successfully added to the database";
    } catch (e) {
      response.code = 500;
      response.message = e.toString();
    }

    if (response.code == 200) {
      String animalId = animalDocumentReferencer.id;

      var adoptionCenterResult = await _adoptionCenters
          .where("adoption_center_id", isEqualTo: currentUserId)
          .get();

      if (adoptionCenterResult.docs.isNotEmpty) {
        // There should be only one adoption center with the given adoption_center_id
        DocumentReference adoptionCenterDocumentReferencer =
            adoptionCenterResult.docs.first.reference;

        await adoptionCenterDocumentReferencer.update({
          "adoption_center_animals": FieldValue.arrayUnion([animalId]),
        });
      }
    }

    return response;
  }

  static Stream<QuerySnapshot> readAnimals() {
    CollectionReference notesItemCollection = _animals;
    return notesItemCollection.snapshots();
  }

  static Future<void> updateAnimal({required Animal animal}) async {
    DocumentReference animalDocumentReferencer = _animals.doc();

    await animalDocumentReferencer.update({
      "name": animal.name,
      "description": animal.description,
      "type": animal.type,
      "breed": animal.breed,
      "color": animal.age,
      "health": animal.health,
      "activity_level": animal.activityLevel,
      "sex": animal.sex,
      "availability": animal.availability,
      "adoptionCenterId": animal.animalId,
    });
  }
}
