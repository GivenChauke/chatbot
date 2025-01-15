import 'package:chatbot/global_variables.dart';
import 'package:flutter/material.dart';
import 'Homepage/Homepage.dart';
import 'LoginPage/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatbot/services/auth/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: const FirebaseOptions (
  apiKey: "AIzaSyCalIFo5teYgqgbXigWiULEo_u8LwXA1BI",
  authDomain: "chatbot-55837.firebaseapp.com",
  databaseURL: "https://chatbot-55837-default-rtdb.firebaseio.com",
  projectId: "chatbot-55837",
  storageBucket: "chatbot-55837.firebasestorage.app",
  messagingSenderId: "263076304352",
  appId: "1:263076304352:web:983b48e7571b68288a0785",
  measurementId: "G-WLP7XNHW17"
   ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Homepage(),
    );
  }
}
