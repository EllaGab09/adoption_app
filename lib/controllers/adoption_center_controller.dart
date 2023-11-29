import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

final FirebaseFirestore _db = FirebaseFirestore.instance;

final CollectionReference _adoptionCenters = _db.collection('adoption_centers');

class AdoptionCenterController {
  static Stream<QuerySnapshot> readAdoptionCenters() {
    CollectionReference notesItemCollection = _adoptionCenters;

    return notesItemCollection.snapshots();
  }
}
