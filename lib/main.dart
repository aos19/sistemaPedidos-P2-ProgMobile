import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://your-supabase-url.supabase.co',
    anonKey: 'MINHA_ANON_KEY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificando se existe uma sessão ativa
    final sessaoAtiva = Supabase.instance.client.auth.currentSession;

    // Retornando em tela a raiz do aplicativo
    return MaterialApp(
      title: "EasyBooking",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // Se houver uma sessão ativa, a tela Home será apresentada, caso não, será a tela de login
      //home: sessaoAtiva != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}