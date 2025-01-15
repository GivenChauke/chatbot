import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  final String username;

  const AvatarIcon({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract first two letters from username, default to "?" if username is empty
    final initials = username.isNotEmpty
        ? username.trim().split(' ').map((name) => name[0]).take(2).join().toUpperCase()
        : 'user';

    return CircleAvatar(
      backgroundColor: Colors.blueGrey, // Customize the background color
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 20, // Adjust the font size
          fontWeight: FontWeight.bold, // Make the text bold
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
