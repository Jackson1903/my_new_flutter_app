import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red, // Text color
        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }
}
