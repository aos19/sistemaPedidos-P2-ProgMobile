
import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://laxyeizpehmkqpmkyrvu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxheHllaXpwZWhta3FwbWt5cnZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk5NTU4NjMsImV4cCI6MjA5NTUzMTg2M30.BCYCQKYZMJ5ta8JgCZmFlnTfaH6EXIKkWnkw55YzlQc',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Verificando se existe uma sessão ativa
    final sessaoAtiva = Supabase.instance.client.auth.currentSession;

    return MaterialApp(
      title: "EasyBooking",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        useMaterial3: true,

        // =========================
        // CORES PRINCIPAIS
        // =========================
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF8FAFC),

        // =========================
        // APP BAR
        // =========================
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F172A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        // =========================
        // BOTÕES
        // =========================
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // =========================
        // FLOATING ACTION BUTTON
        // =========================
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF0F172A),
          foregroundColor: Colors.white,
          elevation: 4,
        ),

        // =========================
        // INPUTS
        // =========================
        inputDecorationTheme: InputDecorationTheme(

          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          labelStyle: const TextStyle(
            color: Color(0xFF475569),
            fontWeight: FontWeight.w500,
          ),

          hintStyle: const TextStyle(
            color: Color(0xFF94A3B8),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE2E8F0),
              width: 1.2,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF0F172A),
              width: 2,
            ),
          ),
        ),

        // =========================
        // CARDS
        // =========================
   
cardTheme: const CardThemeData(
  color: Colors.white,
  elevation: 3,
  shadowColor: Colors.black12,
  margin: EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  ),
),


        // =========================
        // ÍCONES
        // =========================
        iconTheme: const IconThemeData(
          color: Color(0xFF0F172A),
        ),

        // =========================
        // TEXTO
        // =========================
        textTheme: const TextTheme(

          headlineMedium: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
          ),

          bodyLarge: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 16,
          ),

          bodyMedium: TextStyle(
            color: Color(0xFF475569),
            fontSize: 14,
          ),
        ),

        // =========================
        // SNACKBAR
        // =========================
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF0F172A),
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // Se houver uma sessão ativa,
      // abre HomeScreen,
      // senão LoginScreen
      home: sessaoAtiva != null
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
