import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.green[600], // Label color
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        fillColor: Colors.grey[100],
        filled: true,
        // Border for normal (enabled) state
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.green[600] ?? Colors.green, // Default green color
            width: 1.5,
          ),
        ),
        // Border for focused state
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.green[800] ?? Colors.green, // Darker green on focus
            width: 2.0,
          ),
        ),
        // Border for error state
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red, // Red color for errors
            width: 1.5,
          ),
        ),
        // Border when there's an error and the field is focused
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.redAccent, // Red accent on focus during error
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
