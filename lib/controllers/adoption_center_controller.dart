import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:adoption_app/models/adoption_center.dart';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

final CollectionReference _adoptionCenters = _db.collection('adoption_centers');

class AdoptionCenterController {
  static Future<Response> addAdoptionCenter(
      {required AdoptionCenter adoptionCenter}) async {
    Response response = Response();
    DocumentReference adoptionCenterDocumentReferencer = _adoptionCenters.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "adoption_center_name": adoptionCenter.name,
      "adoption_center_description": adoptionCenter.description,
      "adoption_center_address": adoptionCenter.location,
      "adoption_center_animals": adoptionCenter.animalIds
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

  static Stream<QuerySnapshot> readAdoptionCenters() {
    CollectionReference notesItemCollection = _adoptionCenters;

    return notesItemCollection.snapshots();
  }
}
