import 'package:flutter/material.dart';
import 'package:adoption_app/services/firebase_authentication.dart';

import '../models/adopter.dart';

class AdopterRegistrationScreen extends StatefulWidget {
  @override
  _AdopterRegistrationScreenState createState() =>
      _AdopterRegistrationScreenState();
}

class _AdopterRegistrationScreenState extends State<AdopterRegistrationScreen> {
  // GlobalKey to uniquely identify the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for handling input fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Method to handle registration and user addition
  void registerAndAddUser() async {
    final age = int.tryParse(_ageController.text) ?? 0;

    // Create Adopter object with user input
    final adopter = Adopter(
      firstname: _firstNameController.text,
      surname: _surnameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      age: age,
      address: UserAddress(
        street: _streetController.text,
        city: _cityController.text,
        zipCode: _zipCodeController.text,
        country: _countryController.text,
      ),
    );

    // Call AuthService to register and add user
    final message = await AuthService().registerAndAddUser(
        firstname: _firstNameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        age: age,
        address: UserAddress(
          street: _streetController.text,
          city: _cityController.text,
          zipCode: _zipCodeController.text,
          country: _countryController.text,
        ),
        adopter: adopter);

    // Close The screen on user registered
    Navigator.pop(context);

    // Show a SnackBar with the registration result message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? 'An error occurred'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(
                  'First Name',
                  _firstNameController,
                  'Enter your first name',
                ),
                const SizedBox(height: 10),
                buildTextField(
                  'Surname',
                  _surnameController,
                  'Enter your surname',
                ),
                const SizedBox(height: 10),
                buildTextField(
                  'Email',
                  _emailController,
                  'Enter your email',
                ),
                const SizedBox(height: 10),
                buildTextField(
                  'Password',
                  _passwordController,
                  'Enter your password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                buildTextField(
                  'Street',
                  _streetController,
                  'Enter your street address',
                ),
                const SizedBox(height: 10),
                buildTextField('City', _cityController, 'Enter your city'),
                const SizedBox(height: 10),
                buildTextField(
                  'Zip Code',
                  _zipCodeController,
                  'Enter your zip code',
                ),
                const SizedBox(height: 10),
                buildTextField(
                  'Country',
                  _countryController,
                  'Enter your country',
                ),
                const SizedBox(height: 10),
                buildTextField('Age', _ageController, 'Enter your age',
                    keyboardType: TextInputType.number),
                const SizedBox(height: 20),

                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      registerAndAddUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text input fields
  Widget buildTextField(
    String labelText,
    TextEditingController controller,
    String hintText, {
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(12.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}
