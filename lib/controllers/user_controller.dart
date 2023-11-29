import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:adoption_app/models/adopter.dart';
import '../models/response.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _users = _db.collection('users');

class UserController {
  static Stream<QuerySnapshot> readUsers() {
    CollectionReference notesItemCollection = _users;

    return notesItemCollection.snapshots();
  }
}
