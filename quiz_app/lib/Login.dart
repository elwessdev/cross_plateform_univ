import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Page"),
              Text("This is where the login form will go."),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {null;},
              //   child: Text('Login'),
              // ),
            ],
          ),
        )
      ),
    );
  }
}