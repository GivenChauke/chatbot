import 'package:chatbot/services/auth/auth.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color darkGreen = Color.fromARGB(255, 7, 88, 11);
  static const Color lightGreen = Color.fromARGB(255, 108, 213, 111);

  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryGreen,
        scaffoldBackgroundColor: lightGreen,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
          bodySmall: TextStyle(color: Colors.white, fontSize: 14),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryGreen,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryGreen,
        ),
      );
}
class UserDetails {
  final String? uid;
  final String? email;
  String? displayName;

  UserDetails({this.uid, this.email, this.displayName});

  // Factory constructor for creating from Firebase User
  factory UserDetails.fromFirebaseUser(user) {
    return UserDetails(
      uid: user?.uid,
      email: user?.email,
      displayName: user?.displayName,
    );
  }

}

// Global instance
UserDetails? currentUserDetails;

// Declare a global variable for storing login status
bool isLoggedIn = false; 

// Function to fetch login status
Future<void> checkLoginStatus() async {
  isLoggedIn = await AuthService().isloggedIn(); // Assign the result after awaiting the future
}

