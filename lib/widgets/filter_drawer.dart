import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({Key? key, required this.onFilterOptionSelected})
      : super(key: key);

  final void Function(String) onFilterOptionSelected;

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
            title: const Text('Filter Option 1'),
            onTap: () {
              onFilterOptionSelected('Option 1');
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Filter Option 2'),
            onTap: () {
              onFilterOptionSelected('Option 2');
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more filter options as needed
        ],
      ),
    );
  }
}
