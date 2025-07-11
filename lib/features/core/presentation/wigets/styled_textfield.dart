import 'package:flutter/material.dart';

class StyledTextfield extends StatelessWidget {
  final String text;

  const StyledTextfield({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    );
  }
}
