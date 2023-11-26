import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:adoption_app/models/user.dart';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _users = _db.collection('users');

class UserController {
  static Future<Response> addAdoptionCenter({required User user}) async {
    Response response = Response();
    DocumentReference userDocumentReferencer = _users.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "user_first_name": user.firstname,
      "user_surname": user.surname,
      "user_email": user.email,
      "user_password": user.password,
      "user_age": user.age,
      "user_address": user.address,
    };

    var result = await userDocumentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  static Stream<QuerySnapshot> readUsers() {
    CollectionReference notesItemCollection = _users;

    return notesItemCollection.snapshots();
  }
}
