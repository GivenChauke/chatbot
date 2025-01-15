import 'package:flutter/material.dart';
import 'package:chatbot/components/side_menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: SizedBox(
          height: 40.0, // Adjust height as needed
          child: Image.asset(
            'assets/images/PngItem_5002858.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body:const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: const Text("Welcome to the Homepage!"),
        ),
      ),
    );
  }
}
