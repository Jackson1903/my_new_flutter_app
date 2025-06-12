import 'package:flutter/material.dart';
import 'package:my_new_flutter_app/views/login_screen.dart';
import 'package:my_new_flutter_app/wigets/styled_button.dart';
import 'package:my_new_flutter_app/data/investments.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  final textButtonBack = 'Regresar';

  @override
  Widget build(BuildContext context) {
    final currentCard = investments[
        0]; // Assuming you want to display the first investment card

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a la Aplicación',
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            StyledButton(
              text: textButtonBack,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
