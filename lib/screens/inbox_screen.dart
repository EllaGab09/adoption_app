import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        onProfilePressed: () {},
      ),
      body: const Center(
        child: Text('Application history will be here'),
      ),
    );
  }
}
