import 'package:chatbot/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Homepage/Homepage.dart';
import 'LoginPage/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatbot/services/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:chatbot/ChatPage/chat_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Provider.of<ChatProvider>(context, listen: false).initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const Homepage(); // Replace with your actual home page widget
          }
        },
      ),
    );
  }
}
