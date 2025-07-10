import 'package:flutter/material.dart';

import '../../data/models/investment.dart';

class StyledCards extends StatelessWidget {
  final List<Investment> investments;
  const StyledCards({required this.investments, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: investments.length,
        itemBuilder: (context, index) {
          final investment = investments[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(investment.cardName),
              subtitle: Text('Monto: ₡${investment.investmentAmount.toStringAsFixed(2)}'),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_forward_ios),
                  SizedBox(width: 8),
                  Icon(Icons.wallet),
                ],
              ),
              contentPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.grey[200],
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(investment.cardType, style: const TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
