import 'package:adoption_app/models/adopter.dart';
import 'package:adoption_app/services/login_state_authentication.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileScreen extends StatelessWidget {
  final Adopter user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LogoAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Display user details here
            ListTile(
              title: const Text(
                'Info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user.email}'),
                  Text('First Name: ${user.firstname}'),
                  Text('Surname: ${user.surname}'),
                  Text('Age: ${user.age.toString()}'),
                ],
              ),
            ),

            ListTile(
              title: const Text(
                'Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Street: ${user.address.street}'),
                  Text('City: ${user.address.city}'),
                  Text('Zip Code: ${user.address.zipCode}'),
                  Text('Country: ${user.address.country}'),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        // Sign out the user
                        FirebaseAuth.instance.signOut();

                        // Set the user as logged out
                        StayLogedInService.setLoggedIn(false);

                        // Navigate to the login screen
                        Navigator.pushNamed(context, '/login');
                      },
                      label: const Text('Logout'),
                      icon: const Icon(Icons.logout),
                      backgroundColor: Theme.of(context).focusColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
