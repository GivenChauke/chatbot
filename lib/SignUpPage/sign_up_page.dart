import 'package:chatbot/components/my_text_field.dart';
import 'package:chatbot/components/my_button.dart';
import 'package:chatbot/components/square_tile.dart';
import 'package:chatbot/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatbot/services/auth/auth.dart';
import 'package:chatbot/Homepage/Homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController NameController = TextEditingController();
  AuthService auth = AuthService();

  void SignUserUp() async{
    final String name = NameController.text;
    final String email = EmailController.text;
    final String password = PasswordController.text;
    try {
      User? user = await auth.signUp(email, password, name);
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  // Method to show error dialog
  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              //logo
              Image.asset('assets/images/PngItem_5002858.png',height: 100,),
              const SizedBox(height: 50),
              //text to welcome user
              const Text("Welcome to Agri-chatbot",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              //name
              MyTextField(
                hintText: 'Name', 
                obscureText: false, 
                controller: NameController
                ),
              const SizedBox(height: 10),
              //email
              MyTextField(
                hintText: 'Email', 
                obscureText: false, 
                controller: EmailController
                ),
              const SizedBox(height: 10),
              //password
                MyTextField(
                hintText: 'Password', 
                obscureText: true, 
                controller: PasswordController
                ),
              const SizedBox(height: 10),
              //login button
              MyButton(
                onTap: () => SignUserUp(),
                text: 'Sign Up',
              ),
              const SizedBox(height: 10),
              //or continue with
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  Text("or continue with"),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
                ),
              ),
              //sign in with google button
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SquareTile(imagePath: 'assets/images/icons8-google-48.png'),
                ],
              ),
              const SizedBox(height: 10),
              //sign up text
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  ),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text('Sign in now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}