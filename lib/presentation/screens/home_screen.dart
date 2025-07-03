import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_new_flutter_app/presentation/screens/new_invesment_screen.dart';
import 'package:my_new_flutter_app/presentation/screens/login_screen.dart';
import 'package:my_new_flutter_app/wigets/styled_button.dart';

import 'package:my_new_flutter_app/wigets/styled_cards.dart';

import '../../data/providers/get_investment_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final investmentProvider = ref.watch(getInvestmentProviderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BAC Investments', style: TextStyle(color: Colors.white)),
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
          investmentProvider.when(
            data: (investments) => StyledCards(
              investments: investments,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
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

  // List<CardInvestment> investments = []; }
  void _openAddOverlayInvestment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: MediaQuery.of(ctx).viewInsets,
        child: Container(
          height: MediaQuery.of(ctx).size.height * 0.4, // 40% del alto de pantalla
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => const NewInvesmentScreen()));
                    // setState(() {
                    //investments.add(
                    //const CardInvestment(
                    //'17',
                    //'Invesment 17',
                    //'FI',
                    //1000.00,
                    // ),
                    // );
                    // });
                    //Navigator.of(ctx).pop();
                  },
                  child: const Text('Agregar Card'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
