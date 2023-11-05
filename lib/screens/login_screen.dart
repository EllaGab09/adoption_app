import 'package:adoption_app/screens/categories_screen.dart';
import 'package:adoption_app/screens/forgot_password_screen.dart';
import 'package:adoption_app/screens/sign_up_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30), // Logo Padding from the top of the screen
              child: Image.asset('assets/images/petAdoptLogo.png'),
            ),
            const SizedBox(height: 20),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false; // Add rememberMe variable

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(), // Solid border
              ),
              hintText: 'Enter your email', // Placeholder text
              contentPadding: const EdgeInsets.all(12.0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(), // Solid border
              ),
              hintText: 'Enter your password', // Placeholder text
              contentPadding: const EdgeInsets.all(12.0),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value!;
                  });
                },
              ),
              const Text('Remember me'),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const CategoriesScreen()));

              String email = emailController.text;
              String password = passwordController.text;

              print('Email: $email, Password: $password');
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), // Make the button rounder
              minimumSize:
                  const Size(200, 50), // Set the button's width and height
            ),
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const ForgotPasswordScreen()));
            },
            child: const Text('Forgot Password?'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //https://pub.dev/packages/sign_in_button
                SignInButton(
                  Buttons.google,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.facebook,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.apple,
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.linkedIn,
                  onPressed: () {},
                ),
                const SizedBox(height: 5),
                const Text("Need an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const SignUpScreen()));
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Remove the minimum button size
                  ),
                  child: const Text('SIGN UP'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
