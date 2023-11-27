import 'package:flutter/material.dart';

class ApplicationItem extends StatelessWidget {
  final String userName;
  final String message;

  const ApplicationItem(
      {super.key, required this.userName, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(userName),
            subtitle: Text(message),
          ),
        ),
      ),
    );
  }
}
