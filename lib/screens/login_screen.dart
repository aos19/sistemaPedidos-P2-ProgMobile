import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthService();

  bool _carregando = false;

  void _executarLogin() async {

    if (_formKey.currentState!.validate()) {

      setState(() {
        _carregando = true;
      });

      try {

        await _authService.login(
          _emailController.text,
          _passwordController.text,
        );

        // Navega para Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

      } catch (e) {

        print(e);

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Erro: $e',
            ),
          ),
        );

      } finally {

        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        toolbarHeight: 90,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              'EasyBooking',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            SizedBox(height: 4),

            Text(
              'Login',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Container(

            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [

                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: Form(

              key: _formKey,

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [

                  const Icon(
                    Icons.hotel_rounded,
                    size: 70,
                    color: Color(0xFF0F172A),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Bem-vindo de volta',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Entre na sua conta para continuar',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF64748B),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  TextFormField(

                    controller: _emailController,

                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(
                        Icons.email_rounded,
                      ),
                    ),

                    validator: (val) {

                      if (val == null || val.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      if (!val.contains('@')) {
                        return 'Digite um e-mail válido';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(

                    controller: _passwordController,

                    obscureText: true,

                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                      ),
                    ),

                    validator: (val) {

                      if (val == null || val.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed:
                          _carregando ? null : _executarLogin,

                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),

                      child: _carregando

                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )

                          : const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const RegisterScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      'Não tem conta? Cadastre-se',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}