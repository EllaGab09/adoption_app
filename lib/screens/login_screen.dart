import 'package:adoption_app/screens/categories_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/petAdoptLogo.png'),
            const SizedBox(height: 20),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
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
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(), // Solid border
              ),
              hintText: 'Enter your email', // Placeholder text
              contentPadding: EdgeInsets.all(12.0),
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
                borderSide: BorderSide(), // Solid border
              ),
              hintText: 'Enter your password', // Placeholder text
              contentPadding: EdgeInsets.all(12.0),
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => CategoriesScreen()));

              String email = emailController.text;
              String password = passwordController.text;

              print('Email: $email, Password: $password');
            },
            child: Text('Login'),
          ),
          TextButton(
            onPressed: () {
              // Handle forgot password
            },
            child: const Text('Forgot Password?'),
          ),
        ],
      ),
    );
  }
}
