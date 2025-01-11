import 'package:chatbot/components/my_text_field.dart';
import 'package:chatbot/components/my_button.dart';
import 'package:chatbot/components/square_tile.dart';
import 'package:chatbot/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatbot/services/auth/auth.dart';
import 'package:chatbot/Homepage/Homepage.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController NameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  AuthService auth = AuthService();

  void SignUserUp(context) async{
    setState(() {
      _isLoading = true;
    });
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (NameController.text.isEmpty || EmailController.text.isEmpty || PasswordController.text.isEmpty) {
        throw 'Please fill in all fields';
      }
      final String name = NameController.text;
      final String email = EmailController.text;
      final String password = PasswordController.text;
      User? user = await auth.signUp(email, password, name);
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } catch (e) {
      _showErrorDialog(context, e.toString());
    } finally {
    setState(() {
      _isLoading = false;
    });
  }
  }

  // Method to show error dialog
   void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (error.contains('[firebase_auth/channel-error] Unable to establish connection on channel.')) {
          error = 'Please make sure your Email and Password fields are filled in';
        } else if (error.contains('[firebase_auth/invalid-email] The email address is badly formatted.')) {
          error = 'Please make sure Email is correct';
        } else if (error.contains('[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.')) {
          error = 'Your Email or Password is incorrect';
        } else if (error.contains('[firebase_auth/network-request-failed]')) {
          error = 'Please make sure you are connected to the internet';
        } else if (error.contains('[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.')) {
          error = 'User not found';
        } else if (error.contains('[firebase_auth/wrong-password] The password is invalid or the user does not have a password.')) {
          error = 'Wrong password';
        } //next do firebase sign up error handling
        else if(error.contains('[firebase_auth/email-already-in-use] The email address is already in use by another account.')){
          error = 'Email already in use';
        } else if(error.contains('[firebase_auth/weak-password] Password should be at least 6 characters')){
          error = 'Password should be at least 6 characters';
        }
        return AlertDialog(
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red[100],
          title: const Text("Sign Up Error"),
          titleTextStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
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
    body: SafeArea(
      child: Stack(
        children: [
          // Main content
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double maxWidth = constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9;

                return Scrollbar(
                  thumbVisibility: false, // Ensures the scrollbar is always visible
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Container(
                          width: maxWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              // Logo
                              Image.asset('assets/images/PngItem_5002858.png', height: 100),
                              const SizedBox(height: 50),
                              // Welcome text
                              const Text(
                                "Welcome to Agri-chatbot",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Name field
                              MyTextField(
                                hintText: 'Name',
                                obscureText: false,
                                controller: NameController,
                              ),
                              const SizedBox(height: 10),
                              // Email field
                              MyTextField(
                                hintText: 'Email',
                                obscureText: false,
                                controller: EmailController,
                              ),
                              const SizedBox(height: 10),
                              // Password field
                              MyTextField(
                                hintText: 'Password',
                                obscureText: true,
                                controller: PasswordController,
                              ),
                              const SizedBox(height: 10),
                              // Forgot password
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Login button
                              MyButton(
                                onTap: () => SignUserUp(context),
                                text: 'Sign Up',
                              ),
                              const SizedBox(height: 10),
                              // Or continue with
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  children: [
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
                              const SizedBox(height: 20),
                              // Sign in with Google
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SquareTile(imagePath: 'assets/images/icons8-google-48.png'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Sign up text
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LoginPage()),
                                      );
                                    },
                                    child: const Text(
                                      'Login in now',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Loading indicator overlay
          if (_isLoading)
            Container(
              color: Colors.black54, // Semi-transparent overlay
              child: Center(
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [
                    Colors.green.shade700,
                    Colors.lightGreen.shade600,
                    Colors.yellow.shade100
                  ],
                  strokeWidth: 2,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}