import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/presentation/screens/home_screen.dart';
import '../../core/wigets/styled_button.dart';

import '../providers/get_investment_provider.dart';

class NewInvesmentScreen extends ConsumerStatefulWidget {
  const NewInvesmentScreen({super.key});

  @override
  ConsumerState<NewInvesmentScreen> createState() {
    return _NewInvesmentState();
  }
}

class _NewInvesmentState extends ConsumerState<NewInvesmentScreen> {
  final montoController = TextEditingController();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final Random _random = Random();
  final _formKey = GlobalKey<FormState>(); // Agregar key para el form
  String selectedType = 'FI'; // Variable para almacenar el tipo seleccionado

  @override
  void dispose() {
    nameController.dispose();
    montoController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BAC Investments', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: nameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Nombre de inversión'),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingrese el nombre de inversión';
                    }
                    if (value.trim().length < 3) {
                      return 'El nombre debe tener al menos 3 caracteres';
                    }
                    return null;
                  }),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(label: Text('Tipo')),
                      items: const [
                        DropdownMenuItem(value: 'FI', child: Text('FI')),
                        DropdownMenuItem(value: 'FP', child: Text('FO')),
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
                      decoration: const InputDecoration(
                        label: Text('Monto'),
                        hintText: 'Ingrese el monto',
                        prefixText: '₡ ',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return _validateAmount(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: StyledButton(
                      text: 'Agregar',
                      onPressed: () {
                        // Validar el formulario antes de proceder
                        if (_formKey.currentState!.validate()) {
                          // Si las validaciones pasan, proceder con el guardado
                          try {
                            final amount = double.parse(montoController.text.trim());
                            final name = nameController.text.trim();

                            setState(() {
                              ref.read(getInvestmentProviderProvider.notifier).addInvestment(
                                    CardInvestment(
                                      _generateRandomId(),
                                      name,
                                      selectedType,
                                      amount,
                                    ),
                                  );
                            });

                            // Limpiar formulario después del éxito
                            _clearForm();

                            // Mostrar mensaje de éxito
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Inversión agregada exitosamente'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Navegar de vuelta
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
                          } catch (e) {
                            // Mostrar error si algo sale mal
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error al agregar inversión: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para generar un ID aleatorio
  String _generateRandomId() {
    return _random.nextInt(999999).toString();
  }

  // Función para limpiar el formulario
  void _clearForm() {
    nameController.clear();
    montoController.clear();
    setState(() {
      selectedType = 'FI';
    });
  }

  // Función para validar monto específicamente
  String? _validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingrese un monto';
    }

    final double? amount = double.tryParse(value.trim());
    if (amount == null) {
      return 'Ingrese un número válido';
    }

    if (amount <= 0) {
      return 'El monto debe ser mayor a 0';
    }

    if (amount > 999999999) {
      return 'El monto excede el límite máximo';
    }

    if (value.contains('.')) {
      final decimals = value.split('.')[1];
      if (decimals.length > 2) {
        return 'Máximo 2 decimales permitidos';
      }
    }

    return null;
  }
}
