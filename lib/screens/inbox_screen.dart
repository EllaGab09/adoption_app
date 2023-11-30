import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:adoption_app/widgets/application_item.dart'; // Import the ApplicationItem widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adoption_app/providers/applications_provider.dart';

/// A screen that displays the inbox for applications.
///
/// This screen is responsible for showing the user's applications, where they can view and manage their applications.
/// It extends the [ConsumerWidget] class, allowing it to rebuild when the state of the underlying data changes.
class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override

  /// Builds the inbox screen widget.
  ///
  /// This method is responsible for constructing the UI of the inbox screen.
  /// It takes in the [context] and [ref] parameters and returns a widget.
  Widget build(BuildContext context, WidgetRef ref) {
    final applications = ref.watch(applicationProvider);
    return Scaffold(
      appBar: const LogoAppBar(),
      body: applications.isEmpty
          ? const Center(
              child: Text(
                'No applications yet.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontFamily: 'Lato',
                ),
              ),
            )
          : ListView.builder(
              itemCount: applications.length,
              itemBuilder: (ctx, i) => ApplicationItem(
                animalName: applications[i].animalName,
                id: applications[i].id,
                userName: applications[i].userName,
                message: applications[i].message,
              ),
            ),
    );
  }
}
