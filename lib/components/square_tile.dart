import 'package:flutter/material.dart';

class SquareTile extends StatefulWidget {
  final String imagePath;
  final Function()? onTap;

  const SquareTile({super.key, required this.imagePath, required this.onTap});

  @override
  _SquareTileState createState() => _SquareTileState();
}

class _SquareTileState extends State<SquareTile> {
  bool _isHovered = false; // Track hover state
  final nonHoverTransform = Matrix4.identity();
  final hoverTransform = Matrix4.identity()..scale(1.1); // Scale effect when hovered

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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: _isHovered ? Colors.blue[100] : Colors.white, // Hover color change
          ),
          transform: _isHovered
              ? hoverTransform // Scale effect when hovered
              : nonHoverTransform, // Reset scale when not hovered
          child: Image.asset(widget.imagePath, height: 40),
        ),
      ),
    );
  }
}
