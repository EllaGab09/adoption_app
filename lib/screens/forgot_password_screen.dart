import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  // ForgotPasswordScreen constructor
  const ForgotPasswordScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with the title "Forgot Password"
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Forgot Password'),
      ),
      // Body of the screen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text explaining the purpose of the screen
            const Text(
              'Enter your email address to reset your password:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            // Text field for entering the email address
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(),
                ),
                hintText: 'Enter your email',
                contentPadding: const EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20),
            // Elevated button to trigger the password reset logic
            ElevatedButton(
              onPressed: () {
                // Handle the password reset logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password reset link sent to your email.'),
                  ),
                );
              },
              // Styling for the elevated button
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              // Text inside the button
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
