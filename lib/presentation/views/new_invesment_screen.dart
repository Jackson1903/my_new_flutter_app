import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_new_flutter_app/data/investments.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/presentation/views/home_screen.dart';

class NewInvesment extends StatefulWidget {
  const NewInvesment({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewInvesmentState();
  }
}

class _NewInvesmentState extends State<NewInvesment> {
  final montoController = TextEditingController();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final Random _random = Random();
  String selectedType = 'FI'; // Variable para almacenar el tipo seleccionado

  // Función para generar un ID aleatorio
  String _generateRandomId() {
    return _random.nextInt(999999).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BAC Investments'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                  controller: nameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Nombre de inversión'),
                  ),
                  validator: (value) {
                    return 'Por favor ingrese el nombre de inversión';
                  }),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(label: Text('Tipo')),
                      items: const [
                        DropdownMenuItem(value: 'FI', child: Text('FI')),
                        DropdownMenuItem(value: 'FP', child: Text('FP')),
                        DropdownMenuItem(value: 'BO', child: Text('BO')),
                        DropdownMenuItem(value: 'CE', child: Text('CE')),
                        DropdownMenuItem(value: 'AC', child: Text('AC')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                      value: selectedType,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: montoController,
                      decoration:
                          const InputDecoration(label: Text('Monto'), hintText: 'Ingrese el monto'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    investments.add(
                      CardInvestment(
                        _generateRandomId(),
                        nameController.text,
                        selectedType, // Usar el valor seleccionado del dropdown
                        montoController.text.isEmpty ? 0.0 : double.parse(montoController.text),
                      ),
                    );
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
