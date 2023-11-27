import 'package:adoption_app/models/adoption_center.dart';
import 'package:adoption_app/screens/adoption_center_screen.dart';
import 'package:adoption_app/screens/user_profile_screen.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/widgets/categories_grid_item.dart';
import 'package:adoption_app/dummy_data/animal_data.dart';

import 'package:adoption_app/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final dummyAdoptionCenter = AdoptionCenter(
  //id: '1',
  imageUrl:
      "https://nebulae-assets.s3.amazonaws.com/3b56d17152bd46c295797a7eaab1f244.jpg",
  name: 'Happy Paws Adoption Center',
  description: 'We provide a loving home for pets of all kinds.',
  phoneNo: '123456789',
  location: AdoptionCenterLocation(
    //location: LatLng(37.7749, -122.4194), // Replace with actual coordinates
    street: '123 Main St',
    city: 'Anytown',
    zipCode: '12345',
    country: 'United States',
  ),
  email: 'test@email.com',
  password: "1234",
  animalIds: ['1', '2', '3'], // Replace with actual animal IDs
);

//Temp Dummy
final dummyUser = User(
  //id: '1',
  //imageUrl:
  //    "https://nebulae-assets.s3.amazonaws.com/3b56d17152bd46c295797a7eaab1f244.jpg",
  firstname: 'John',
  surname: 'Doe',
  email: 'john@example.com',
  password: 'securepassword',
  age: 30,
  address: UserAddress(
    street: '123 Main St',
    city: 'Anytown',
    zipCode: '12345',
    country: 'United States',
  ),
);

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: LogoAppBar(
      //   onProfilePressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => UserProfileScreen(user: dummyUser),
      //       ),
      appBar: LogoAppBar(
        onProfilePressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  AdoptionCenterScreen(adoptionCenter: dummyAdoptionCenter),
            ),
          );
        },
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio:
                    3 / 4, // Adjust the aspect ratio for better item spacing
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                for (final animal in dummyAnimals)
                  CategoryGridItem(animal: animal)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
