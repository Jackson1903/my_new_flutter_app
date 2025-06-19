import 'package:flutter/material.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/presentation/views/login_screen.dart';
import 'package:my_new_flutter_app/wigets/styled_button.dart';
import 'package:my_new_flutter_app/data/investments.dart';

import 'package:my_new_flutter_app/wigets/styled_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  void _openAddOverlayInvestment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Text('Booton Sheet'),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BAC Investments'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _openAddOverlayInvestment(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const StyledCards(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: StyledButton(
              text: 'Logout',
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

  void _addInvestment(CardInvestment cardInvestment) {
    setState(() {
      investments.add(cardInvestment);
    });
    // Aquí puedes agregar la lógica para agregar una nueva inversión
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void setState(Null Function() param0) {}
}
