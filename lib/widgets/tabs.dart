import 'package:adoption_app/controllers/user_controller.dart';
import 'package:adoption_app/screens/adoption_center_screen.dart';
import 'package:adoption_app/screens/categories_screen.dart';
import 'package:adoption_app/screens/favorites_screen.dart';
import 'package:adoption_app/screens/inbox_screen.dart';
import 'package:adoption_app/screens/user_profile_screen.dart';
import 'package:adoption_app/services/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/dummy_data/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A StatefulWidget that represents a screen with tabs.
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0; // Index of the currently selected tab
  var _user_id;
  var _role;
  var _user;

  late Widget profileScreen;

  final List<Widget> _children = [
    const CategoriesScreen(), // Screen for displaying pet categories
    const FavoritesScreen(), // Screen for displaying favorite pets
    const InboxScreen(), // Screen for displaying adoption applications
    UserProfileScreen(
        user: dummyUser), // Screen for user profile with a dummy user
  ];
  void setProfileScreen() {
    if (_role == "adopter") {
      profileScreen = UserProfileScreen(user: _user);
    } else if (_role == "adoptionCenter") {
      profileScreen = AdoptionCenterScreen(adoptionCenter: _user);
    }
  }

  // Callback function for handling tab selection
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected tab index

      _user_id = FirebaseAuth
          .instance.currentUser?.uid; // Retrieve the user ID on tab change
      UserController.readUsers().forEach((element) {
        element.docs.forEach((element) {
          if (element.id == _user_id) {
            _user = element.data();
            _role = _user['role'];
          }
        });
      });
    });

    print("role: $_role");
    print("user: $_user");

    setProfileScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body: Display the current screen based on the selected tab index
      body: _children[_currentIndex],

      // Bottom Navigation Bar: Tabs for navigating between screens
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
