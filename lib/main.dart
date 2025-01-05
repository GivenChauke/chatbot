import 'package:flutter/material.dart';
import 'Homepage/Homepage.dart';
import 'LoginPage/login_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
