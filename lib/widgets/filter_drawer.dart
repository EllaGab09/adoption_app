import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key, required this.onFilterOptionSelected});

  final void Function(String, String) onFilterOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Filter Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Filter by Animal'),
            onTap: () {
              // Implement logic to filter by type
              onFilterOptionSelected('type', 'Dog');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Filter by Breed'),
            onTap: () {
              // Implement logic to filter by breed
              onFilterOptionSelected('breed', 'Labrador');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Filter by Color'),
            onTap: () {
              // Implement logic to filter by color
              onFilterOptionSelected('color', 'Brown');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Filter by Age'),
            onTap: () {
              // Implement logic to filter by age
              onFilterOptionSelected('age', '2');
              Navigator.pop(context);
            },
          ),
          // Add more filter options as needed
        ],
      ),
    );
  }
}
