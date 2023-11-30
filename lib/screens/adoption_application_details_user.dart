import 'package:adoption_app/models/animal.dart';
import 'package:flutter/material.dart';

class AdoptionApplicationDetails extends StatelessWidget {
  //final AdoptionApplication adoptionApplication;
  final String userName;
  final String userMessage;
  final String adoptionCenter;
  //final String animalInfo;
  final String animal;

  const AdoptionApplicationDetails({
    super.key,
    required this.userName,
    required this.userMessage,
    required this.adoptionCenter,
    //required this.animalInfo,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Application Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'User Name: $userName',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'User Message: $userMessage',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Adoption Center: $adoptionCenter',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Animal: $animal',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
