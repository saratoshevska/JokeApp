import 'package:flutter/material.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/randomJoke.dart';

void main() {
  runApp(JokeApp());
}

class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/random': (context) => RandomJokeScreen(),
      },
    );
  }
}