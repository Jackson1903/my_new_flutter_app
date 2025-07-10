import 'package:flutter/material.dart';
import 'package:my_new_flutter_app/presentation/screens/home_screen.dart';
import '../../core/presentation/wigets/styled_button.dart';
import '../../core/presentation/wigets/styled_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(children: [
            const SizedBox(height: 220),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  StyledTextfield(text: 'Usuario'),
                  SizedBox(height: 20),
                  StyledTextfield(text: 'Contraseña')
                ],
              ),
            ),
            const SizedBox(height: 290),
            StyledButton(
              text: 'Ingresar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
