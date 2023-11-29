import 'package:adoption_app/screens/categories_screen.dart';
import 'package:adoption_app/screens/favorites_screen.dart';
import 'package:adoption_app/screens/inbox_screen.dart';
import 'package:adoption_app/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/dummy_data/user_data.dart';

/// A StatefulWidget that represents a screen with tabs.
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0; // Index of the currently selected tab
  final List<Widget> _children = [
    const CategoriesScreen(), // Screen for displaying pet categories
    const FavoritesScreen(), // Screen for displaying favorite pets
    const InboxScreen(), // Screen for displaying adoption applications
    UserProfileScreen(
        user: dummyUser), // Screen for user profile with a dummy user
  ];

  // Callback function for handling tab selection
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body: Display the current screen based on the selected tab index
      body: _children[_currentIndex],

      // Bottom Navigation Bar: Tabs for navigating between screens
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context)
              .colorScheme
              .primary, // Replace with your desired color
        ),
        child: BottomNavigationBar(
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
          selectedItemColor: Theme.of(context).colorScheme.onSecondary,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
