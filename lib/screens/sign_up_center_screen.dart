import 'package:adoption_app/models/adoption_center.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/services/firebase_authentication.dart';

class AdoptionCenterRegistrationScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void registerAndAddAdoptionCenter(BuildContext context) async {
    final adoption_center = AdoptionCenter(
      name: _nameController.text,
      description: _descriptionController.text,
      phoneNo: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
      location: AdoptionCenterLocation(
        street: _streetController.text,
        city: _cityController.text,
        zipCode: _zipCodeController.text,
        country: _countryController.text,
      ),
    );
    final message = await AuthService().registerAndAddAdoptionCenter(
        name: _nameController.text,
        description: _descriptionController.text,
        phoneNo: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
        location: AdoptionCenterLocation(
          street: _streetController.text,
          city: _cityController.text,
          zipCode: _zipCodeController.text,
          country: _countryController.text,
        ),
        adoptionCenter: adoption_center);
    //Close The screen on user registered
    Navigator.pop(context);

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
              buildTextField('Name', _nameController, 'Enter your first name'),
              const SizedBox(height: 10),
              buildTextField('Email', _emailController, 'Enter your email'),
              const SizedBox(height: 10),
              buildTextField(
                  'Phone number', _phoneController, 'Enter your phone number'),
              const SizedBox(height: 10),
              buildTextField(
                  'Password', _passwordController, 'Enter your password',
                  obscureText: true),
              const SizedBox(height: 10),
              buildTextField('Description', _descriptionController,
                  'Please describe your adoption center'),
              const SizedBox(height: 10),
              buildTextField(
                  'Street', _streetController, 'Enter your street address'),
              const SizedBox(height: 10),
              buildTextField('City', _cityController, 'Enter your city'),
              const SizedBox(height: 10),
              buildTextField(
                  'Zip Code', _zipCodeController, 'Enter your zip code'),
              const SizedBox(height: 10),
              buildTextField(
                  'Country', _countryController, 'Enter your country'),
              const SizedBox(height: 20),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  registerAndAddAdoptionCenter(context);
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

  Widget buildTextField(
      String labelText, TextEditingController controller, String hintText,
      {bool obscureText = false, TextInputType? keyboardType}) {
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
    );
  }
}
