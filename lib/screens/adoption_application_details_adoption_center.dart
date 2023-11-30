import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/widgets/adoption_application_details.dart';
import 'package:flutter/material.dart';

class AdoptionApplicationDetailsAC extends StatefulWidget {
  @override
  _AdoptionApplicationDetailsACState createState() =>
      _AdoptionApplicationDetailsACState();

  final String userName;
  final String userMessage;
  final String adoptionCenter;
  final String animalInfo;
  final Animal animal;

  // Constructor for the AdoptionApplicationDetailsAC widget
  const AdoptionApplicationDetailsAC({
    super.key,
    required this.userName,
    required this.userMessage,
    required this.adoptionCenter,
    required this.animalInfo,
    required this.animal,
  });
}

class _AdoptionApplicationDetailsACState
    extends State<AdoptionApplicationDetailsAC> {
  // Variable to track if buttons should be disabled
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    // Initialize button disabled status based on the application status
    _isButtonDisabled = status == "Pending" ? false : true;
  }

  // Application status
  var status = "Pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display adoption application details
              AdoptionApplicationDetails(
                  userName: "John",
                  userMessage: "I would like to adopt!",
                  adoptionCenter: "Happy Paws",
                  animal: widget.animal),
              const Spacer(),
              // ACCEPT ADOPTION Button
              ElevatedButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () {
                        status = "Meeting request sent!";
                        _isButtonDisabled = true;
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Square button
                  ),
                ),
                child: const Text("Aprove Adoption"),
              ),

              // REJECT ADOPTION
              ElevatedButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () {
                        status = "Meeting request denied!";
                        _isButtonDisabled = true;
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Square button
                  ),
                ),
                child: const Text("Reject Adoption"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
