import 'package:chatbot/components/my_text_field.dart';
import 'package:chatbot/components/my_button.dart';
import 'package:chatbot/components/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  void SignUserIn(){
    final String username = EmailController.text;
    final String password = PasswordController.text;
    print("Username: $username");
    print("Password: $password");
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
              const Text("Welcome back to Agri-chatbot",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              
              ),
              const SizedBox(height: 30),
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
              //forgot password
              Text("Forgot Password?",
              style: TextStyle(
                color: Colors.grey[600],
              ),
              ),
              const SizedBox(height: 10),
              //login button
              MyButton(
                onTap: SignUserIn,
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
                  Text("Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  ),
                  const SizedBox(width: 5),
                  const Text("Sign Up now",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
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