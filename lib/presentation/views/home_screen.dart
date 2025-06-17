import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_new_flutter_app/presentation/views/login_screen.dart';
import 'package:my_new_flutter_app/wigets/styled_button.dart';
import 'package:my_new_flutter_app/data/investments.dart';
import 'package:my_new_flutter_app/wigets/styled_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final textButtonBack = 'Logout';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          const SizedBox(height: 20),
          StyledCards(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: StyledButton(
              text: textButtonBack,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
