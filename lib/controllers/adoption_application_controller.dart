import 'package:adoption_app/models/adoption_application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

final CollectionReference _adoptionApplications =
    _db.collection('adoptionApplications');

class AdoptionApplicationController {
  // CREATE application
  static Future<Response> addApplication(
      {required AdoptionApplication application}) async {
    Response response = Response();
    DocumentReference applicationDocumentReferencer =
        _adoptionApplications.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "application_id": application.applicationId ?? "",
      "user_id": application.userId ?? "",
      "animal_id": application.animalId ?? "",
      "application_status": application.applicationStatus ?? "",
      "application_message": application.applicationMessage ?? "",
    };

    /*
      TODO: 
            - Read the applications 
            - check if there exists ones with the same user_id and animal_id
            - if there is, return an error
            - if there isn't, add the application to the database

    */

    // Try to add the application in the database
    // Return a response with the status code and message of the operation
    await applicationDocumentReferencer
        .set(data) // Add the application to the collection
        .whenComplete(() {
      // When the operation is complete and succesfull
      response.code = 200; // Set the status code to success
      response.message = "Application successfully added to the database";
    }).catchError((e) {
      // When the operation is not succesfull
      response.code = 500; // Set the status code to error
      response.message = e.toString();
    });

    return response; // Return the object containing the response from the operation
  }

  //READ all applications
  static Stream<QuerySnapshot> getApplications() {
    print(_adoptionApplications.snapshots().toString());
    return _adoptionApplications.snapshots();
  }

  //READ application by id
  Future<DocumentSnapshot?> getApplicationById({
    required String applicationId,
  }) async {
    QuerySnapshot querySnapshot = await _adoptionApplications.get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        if (doc.id == applicationId) {
          return doc;
        }
      }
    }
    return null;
  }

  //DELETE application
  static Future<Response> deleteApplication({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference applicationDocumentReferencer =
        _adoptionApplications.doc(docId);

    await applicationDocumentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Application";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  //UPDATE application status
  static Future<Response> updateApplicationStatus({
    required AdoptionApplication application,
    required String newStatus,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _adoptionApplications.doc(application.applicationId);

    Map<String, dynamic> data = <String, dynamic>{
      "application_id": application.applicationId ?? "",
      "user_id": application.userId ?? "",
      "animal_id": application.animalId ?? "",
      "application_status": newStatus ?? "",
      "application_message": application.applicationMessage ?? "",
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Application status";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
