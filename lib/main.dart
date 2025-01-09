import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/randomJoke.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();


  await FirebaseMessaging.instance.requestPermission();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(JokeApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
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
