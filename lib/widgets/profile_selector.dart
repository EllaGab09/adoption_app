import 'package:adoption_app/dummy_data/user_data.dart';
import 'package:adoption_app/models/adoption_center.dart';
import 'package:adoption_app/screens/adoption_center_screen.dart';
import 'package:adoption_app/screens/user_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileSelector extends StatefulWidget {
  @override
  _UserProfileSelectorState createState() => _UserProfileSelectorState();
}

class _UserProfileSelectorState extends State<UserProfileSelector> {
  bool isUser = false;
  var user;
  var adoptionCenter;
  Future setUserAndRole() async {
    // Get the user data and check if the user is a regular user or an adoption center
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              if (data['user_id'] == FirebaseAuth.instance.currentUser?.uid) {
                setState(() {
                  isUser = true;
                  user = data;
                });
              }
            }));
    if (!isUser) {
      await FirebaseFirestore.instance
          .collection('adoption_centers')
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                if (data['adoption_center_id'] ==
                    FirebaseAuth.instance.currentUser?.uid) {
                  setState(() {
                    adoptionCenter = data;
                  });
                }
              }));
    }

    print(FirebaseAuth.instance.currentUser?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setUserAndRole(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (isUser) {
            return UserProfileScreen(user: dummyUser);
          } else {
            return AdoptionCenterScreen(
                adoptionCenter: AdoptionCenter(
                    name: "name",
                    description: "description",
                    phoneNo: "phoneNo",
                    location: AdoptionCenterLocation(
                        city: "city", street: "", country: "", zipCode: ""),
                    email: "email",
                    password: "password"));
          }
        }
      },
    );
  }
}
