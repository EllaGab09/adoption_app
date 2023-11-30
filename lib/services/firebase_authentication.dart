import 'package:adoption_app/models/adoption_center.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';
import '../models/adopter.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _adoptionCenters = _db.collection('adoption_centers');
final CollectionReference _users = _db.collection('users');

class AuthService {
  String? userId;
  String? adoptionCenterId;
  Future<String?> registerAndAddUser({
    required String firstname,
    required String surname,
    required String email,
    required String password,
    required int age,
    required UserAddress address,
    required Adopter adopter,
  }) async {
    try {
      // Register the user
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCreds) {
        userId = userCreds.user?.uid;
      });

      // Add user data to the database
      await addUser(adopter: adopter, userId: userId!);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<Response> addUser(
      {required Adopter adopter, required String userId}) async {
    Response response = Response();
    DocumentReference userDocumentReferencer = _users.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "adopter_first_name": adopter.firstname ?? "",
      "adopter_surname": adopter.surname ?? "",
      "adopter_age": adopter.age ?? 0,
      "adopter_id": userId,
    };

    data["adopter_address"] = adopter.address.toMap();

    if (adopter.applicationIds != null) {
      data["adopter_application_ids"] = adopter.applicationIds!;
    }

    try {
      await userDocumentReferencer.set(data);
      response.code = 200;
      response.message = "Successfully added to the database";
    } catch (e) {
      response.code = 500;
      response.message = e.toString();
    }

    return response;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> registerAndAddAdoptionCenter({
    required String name,
    required String description,
    required AdoptionCenterLocation location,
    required String phoneNo,
    required String email,
    required String password,
    required AdoptionCenter adoptionCenter,
  }) async {
    try {
      // Register the user
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCreds) {
        adoptionCenterId = userCreds.user?.uid;
      });

      // Add adoption center
      await addAdoptionCenter(
          adoptionCenter: adoptionCenter, adoptionCenterId: adoptionCenterId!);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Response> addAdoptionCenter(
      {required AdoptionCenter adoptionCenter,
      required adoptionCenterId}) async {
    Response response = Response();
    DocumentReference adoptionCenterDocumentReferencer = _adoptionCenters.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "adoption_center_name": adoptionCenter.name ?? "",
      "adoption_center_description": adoptionCenter.description ?? "",
      "adoption_center_phone": adoptionCenter.phoneNo ?? "",
      "adoption_center_address": adoptionCenter.location ?? "",
      "adoption_center_animals": adoptionCenter.animalIds ?? "",
      "adoption_center_id": adoptionCenterId
    };

    if (adoptionCenter.location != null) {
      data["adoption_center_address"] = adoptionCenter.location!.toMap();
    }

    if (adoptionCenter.animalIds != null) {
      data["adoption_center_animals"] = adoptionCenter.animalIds!;
    }

    try {
      await adoptionCenterDocumentReferencer.set(data);
      response.code = 200;
      response.message = "Successfully added to the database";
    } catch (e) {
      response.code = 500;
      response.message = e.toString();
    }
    return response;
  }
}
