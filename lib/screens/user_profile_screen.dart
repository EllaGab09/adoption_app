import 'package:adoption_app/models/adopter.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final Adopter user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        onProfilePressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250, // Set the image container height
              // child: Image.network(
              //   user.imageUrl,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle the "User Profile" tap
                    },
                    child: const Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(), // Add some spacing between the text and the icon
                  InkWell(
                    onTap: () {
                      // Handle the "Messages" tap
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Inbox ',
                          style: TextStyle(
                            fontSize: 18,
                            //  fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.mail_outline),
                      ],
                    ),
                  )
                ],
              ),
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
          ],
        ),
      ),
    );
  }
}
