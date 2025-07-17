import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/presentation/wigets/styled_button.dart';
import '../../investment/presentation/screen/home_screen.dart';
import 'viewmodel/user_auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserAuthState>(userAuthViewModelProvider, (previous, next) {
      if (next == UserAuthState.authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (next == UserAuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error during login')),
        );
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(height: 220),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'ejemplo@correo.com',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      enableSuggestions: false,
                      // Fuerza el uso del teclado virtual
                      enableInteractiveSelection: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su email';
                        }
                        if (!value.contains('@')) {
                          return 'Por favor ingrese un email válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Mínimo 6 caracteres',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autocorrect: false,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 250),
              StyledButton(
                text: 'Ingresar',
                onPressed: () {
                  final stateAuth = ref.watch(userAuthViewModelProvider);
                  if (stateAuth != UserAuthState.loading) {
                    if (_formKey.currentState!.validate()) {
                      handleLogin(ref);
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              StyledButton(
                text: 'Registrarse',
                onPressed: () {
                  final stateAuth = ref.watch(userAuthViewModelProvider);
                  if (stateAuth != UserAuthState.loading) {
                    if (_formKey.currentState!.validate()) {
                      handleRegister(ref);
                    }
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin(WidgetRef ref) async {
    await ref
        .read(userAuthViewModelProvider.notifier)
        .isAuthenticated(user: _emailController.text, password: _passwordController.text);
  }

  Future<void> handleRegister(WidgetRef ref) async {
    // Por ahora usa la misma función de login
    // Aquí puedes implementar la lógica de registro más tarde
    await ref
        .read(userAuthViewModelProvider.notifier)
        .isRegister(user: _emailController.text, password: _passwordController.text);
  }
}

// Remover la función global ya que ahora está dentro de la clase
