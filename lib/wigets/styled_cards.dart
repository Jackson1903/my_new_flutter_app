import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_new_flutter_app/data/providers/get_investment_provider.dart';
import '../data/models/card_investment.dart';

class StyledCards extends ConsumerWidget {
  final List<CardInvestment> investments;
  const StyledCards({required this.investments, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final investmentProvider = ref.watch(getInvestmentProviderProvider);

    return Expanded(
      child: investmentProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(getInvestmentProviderProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (investments) => ListView.builder(
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
      ),
    );
  }
}
