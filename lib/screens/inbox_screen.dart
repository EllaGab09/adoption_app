import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:adoption_app/widgets/application_item.dart'; // Import the ApplicationItem widget
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adoption_app/providers/applications_provider.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
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
                id: applications[i].id,
                message: applications[i].message,
              ),
            ),
    );
  }
}
