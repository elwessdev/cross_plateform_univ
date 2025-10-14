import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wessNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/notes': (context) => NotesScreen(),
      },
    );
  }
}