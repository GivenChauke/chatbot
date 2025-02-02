import 'package:chatbot/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Homepage/Homepage.dart';
import 'LoginPage/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatbot/services/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:chatbot/ChatPage/chat_provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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

    // Fetch Remote Config values
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  await _remoteConfig.fetchAndActivate();
  final String _apiKey = _remoteConfig.getString('GEMINI_API_KEY');

  // Run the app only after fetching API key
  runApp(MyApp(apiKey: _apiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;
  const MyApp({Key? key, required this.apiKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider(apiKey)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(), // Use Homepage directly since API is ready
      ),
    );
  }
}
