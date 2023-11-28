import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/widgets/adoption_application_details.dart';
import 'package:flutter/material.dart';

class AdoptionApplicationDetailsAC extends StatefulWidget {
  @override
  _AdoptionApplicationDetailsACState createState() =>
      _AdoptionApplicationDetailsACState();

  //final AdoptionApplication adoptionApplication;
  final String userName;
  final String userMessage;
  final String adoptionCenter;
  final String animalInfo;
  final Animal animal;

  AdoptionApplicationDetailsAC({
    required this.userName,
    required this.userMessage,
    required this.adoptionCenter,
    required this.animalInfo,
    required this.animal,
  });
}

class _AdoptionApplicationDetailsACState
    extends State<AdoptionApplicationDetailsAC> {
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = status == "Pending" ? false : true;
  }

  var status = "Pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdoptionApplicationDetails(
                  userName: "John",
                  userMessage: "I would like to adopt!",
                  adoptionCenter: "Happy Paws",
                  animal: widget.animal),
              const Spacer(),
              // ACCEPT ADOPTION
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
