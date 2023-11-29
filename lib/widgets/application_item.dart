import 'package:adoption_app/dummy_data/user_data.dart';
import 'package:adoption_app/providers/applications_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationItem extends ConsumerWidget {
  final String id;
  final String userName;
  final String message;

  const ApplicationItem(
      {super.key,
      required this.id,
      required this.userName,
      required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applications = ref.watch(applicationProvider);
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
            title: Text("Application from $userName"),
            subtitle: Text(message),
            trailing: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.delete),
              color: Colors.red,
              highlightColor: Colors.yellow,
              splashColor: Colors.green,
              tooltip: 'Delete Application',
              onPressed: () {
                ref.read(applicationProvider.notifier).removeApplication(
                    applications.firstWhere((element) => element.id == id));
              },
            ),
          ),
        ),
      ),
    );
  }
}
