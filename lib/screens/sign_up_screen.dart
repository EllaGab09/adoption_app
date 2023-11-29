import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // First Name Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your first name',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 10),
              // Surname Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your surname',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 10),
              // Email Input
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
              const SizedBox(height: 10),
              // Password Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your password',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              // Birth Day Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Birth Day',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your birth day',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 10),
              // Street Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your street address',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 10),
              // City Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your city',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 10),
              // Zip Code Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Zip Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your zip code',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 10),
              // Country Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(),
                  ),
                  hintText: 'Enter your country',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 20),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Handle sign up logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created successfully.'),
                    ),
                  );
                },
                child: const Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
