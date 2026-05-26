// Funções de logar, cadastrar e deslogar os usuários
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Garantindo uma instância do cliente
  final SupabaseClient _supabase = Supabase.instance.client;

   Future<void> cadastrar(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  User? get usuarioAtual => _supabase.auth.currentUser;
}
