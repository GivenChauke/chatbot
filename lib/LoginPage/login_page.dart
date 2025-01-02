import 'package:chatbot/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              //logo
              Icon(Icons.chat_bubble_outline, size: 100),
              //text to welcome user
              Text("Welcome to Chatbot",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 25),
              //email
              MyTextField(
                hintText: 'Email', 
                obscureText: false, 
                controller: controller
                ),
              const SizedBox(height: 10),
              //password
                MyTextField(
                hintText: 'Password', 
                obscureText: true, 
                controller: controller
                ),
              const SizedBox(height: 25),
              //login button
              //register button
            ],
          ),
        ),
      )
    );
  }
}