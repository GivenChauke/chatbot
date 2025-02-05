import 'package:chatbot/ChatPage/chat_page.dart';
import 'package:chatbot/Homepage/Homepage.dart';
import 'package:chatbot/LoginPage/login_page.dart';
import 'package:chatbot/components/avatar_icon.dart';
import 'package:chatbot/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/services/auth/auth.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  void logout(BuildContext context) {
    AuthService().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.lightTheme.primaryColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              currentUserDetails?.displayName ?? "Guest",
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            accountEmail: Text(
              currentUserDetails?.email ?? "GuestEmail",
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            currentAccountPicture: AvatarIcon(
              username: currentUserDetails?.displayName ?? "Guest",
            ),
            decoration: const BoxDecoration(
              color: AppTheme.darkGreen,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: Text(
              'Chat now!',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage(promptContext: '',)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              isLoggedIn ? 'Logout' : 'Login',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            onTap: () {
              if (isLoggedIn) {
                logout(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
