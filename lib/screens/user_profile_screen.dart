import 'package:adoption_app/models/user.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

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
              child: Image.network(
                user.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
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
              title: const Text('Email'),
              subtitle: Text(user.email),
            ),
            ListTile(
              title: const Text('Age'),
              subtitle: Text(user.age.toString()),
            ),
            ListTile(
              title: const Text('Street'),
              subtitle: Text(user.address.street),
            ),
            ListTile(
              title: const Text('City'),
              subtitle: Text(user.address.city),
            ),
            ListTile(
              title: const Text('Zip Code'),
              subtitle: Text(user.address.zipCode),
            ),
            ListTile(
              title: const Text('Country'),
              subtitle: Text(user.address.country),
            ),
          ],
        ),
      ),
    );
  }
}
