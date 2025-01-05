import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class MyButton extends StatelessWidget{
  final Function()? onTap;
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration:  BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}