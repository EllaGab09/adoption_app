import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class AdoptionApplicationDetails extends StatelessWidget {
  //final AdoptionApplication adoptionApplication;
  final String userName;
  final String userMessage;
  final String adoptionCenter;
  final String animalInfo;
  final Animal animal;

  AdoptionApplicationDetails({
    required this.userName,
    required this.userMessage,
    required this.adoptionCenter,
    required this.animalInfo,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Name: $userName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'User Message: $userMessage',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Adoption Center: $adoptionCenter',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Animal Info: $animalInfo',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
