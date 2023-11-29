import 'package:adoption_app/screens/forgot_password_screen.dart';
import 'package:adoption_app/screens/sign_up_screen.dart';
import 'package:adoption_app/widgets/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:adoption_app/services/firebase_authentication.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo Image
              Padding(
                padding: const EdgeInsets.only(
                    top: 30), // Logo Padding from the top of the screen
                child: Image.asset('assets/images/petAdoptLogo.png'),
              ),
              const SizedBox(height: 20),
              const LoginForm(), // Display the login form
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controllers for email and password input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false; // Track the state of the "Remember me" checkbox

  @override
  void initState() {
    super.initState();
    loadRememberMeState();
  }

  void loadRememberMeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  void saveRememberMeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', rememberMe);
    if (rememberMe) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Login Title
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
          // Email Input Field
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
          // Password Input Field
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
            obscureText: true, // Hide password text
          ),
          const SizedBox(height: 20),
          // "Remember me" Checkbox
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
          // Login Button
          ElevatedButton(
            onPressed: () async {
              String? result = await AuthService().login(
                  email: emailController.text,
                  password: passwordController.text);

              if (result!.contains('Success')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login Successful'),
                  ),
                );
                saveRememberMeState(); // Save the state after successful login
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const TabsScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.toString()),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), // Make the button rounder
              minimumSize:
                  const Size(200, 50), // Set the button's width and height
            ),
            child: const Text('Login'),
          ),
          // Forgot Password Button
          TextButton(
            onPressed: () {
              // Navigate to the ForgotPasswordScreen on button press
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const ForgotPasswordScreen()));
            },
            child: const Text('Forgot Password?'),
          ),
          // Third-party Sign In Buttons
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                // Sign Up Text Button
                const Text("Need an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
