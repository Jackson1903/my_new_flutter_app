import 'package:flutter/material.dart';
import 'package:my_new_flutter_app/presentation/views/login_screen.dart';
import 'package:my_new_flutter_app/wigets/styled_button.dart';
import 'package:my_new_flutter_app/data/investments.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  final textButtonBack = 'Logout';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: investments.length,
              itemBuilder: (context, index) {
                final investment = investments[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(investment.cardName ?? ''),
                    contentPadding: const EdgeInsets.all(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.grey[200],
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(investment.cardType ?? '',
                          style: const TextStyle(color: Colors.white)),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle tap if needed
                    },
                    subtitle:
                        Text('Monto: ${investment.investmentAmount ?? ''}'),
                  ),
                );
              },
            ),
          ),
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
    );
  }
}
