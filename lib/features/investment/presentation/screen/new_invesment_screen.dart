import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_new_flutter_app/features/investment/presentation/utils/investment_helper.dart';
import '../../../core/presentation/wigets/styled_button.dart';
import 'home_screen.dart';

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
  InvestmentHelper investmentHelper = InvestmentHelper();

  final _formKey = GlobalKey<FormState>();
  String selectedType = 'FI';

  @override
  void dispose() {
    nameController.dispose();
    montoController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ref = this.ref;
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
                        investmentHelper.validateAmount(value);
                        return (value);
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
                        if (_formKey.currentState!.validate()) {
                          try {
                            _clearForm();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Inversión agregada exitosamente'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
                          } catch (e) {
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

  void _clearForm() {
    nameController.clear();
    montoController.clear();
    setState(() {
      selectedType = 'FI';
    });
  }
}
