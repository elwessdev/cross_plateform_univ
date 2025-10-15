import 'package:flutter/material.dart';
import "SplashScreen.dart";
import "Auth/Signin.dart";
import "Auth/Signup.dart";
import 'Service/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'App/Game.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://hqwpikxeejsutniyhssm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhxd3Bpa3hlZWpzdXRuaXloc3NtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA0NzIzMzIsImV4cCI6MjA3NjA0ODMzMn0.oCYorJZ2RvJOv0Pc9_buI3dJ7sXy7hHHFNdWKkROiJU',
  );
  runApp(const MyApp());
}

// #4e75ff
// #0a1653

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wessQuizyy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF0a1653),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/authgate': (context) => const AuthGate(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/game': (context) => const GamePage(),
      },
    );
  }
}

