import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatefulWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isHovered = false; // Track hover state
  final nonHoverTransform = Matrix4.identity();
  final hoverTransform = Matrix4.identity()..scale(1.02); // Scale effect when hovered

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // On tap callback
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true; // Set hover state to true
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false; // Reset hover state
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300), // Smooth transition
          height: 50,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.blue[400] : Colors.grey[700], // Hover color change
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          transform: _isHovered
              ? hoverTransform // Scale effect when hovered
              : nonHoverTransform, // Reset scale when not hovered
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
