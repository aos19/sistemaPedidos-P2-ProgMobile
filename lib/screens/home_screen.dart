import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import 'login_screen.dart';

// Widget com estado para controlar as tarefas
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _dbService = DatabaseService();
  final _authService = AuthService();
  final _tituloController = TextEditingController();
  final _precoController = TextEditingController();

  // Abre uma janela para criar/editar um registro
  void _abrirFormularioModal({Hospedagem? itemExistente}) {
    if (itemExistente != null) {
      _tituloController.text = itemExistente.titulo;
      _precoController.text = itemExistente.preco.toString();
    } else {
      _tituloController.clear();
      _precoController.clear();
    }

    // Painel que desliza de baixo para cima, interagindo com o usuário, caixa de diálogo
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _tituloController, decoration: const InputDecoration(labelText: 'Nome da Hospedagem')),
            TextField(controller: _precoController, decoration: const InputDecoration(labelText: 'Preço por Noite'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final novaHospedagem = Hospedagem(
                  id: itemExistente?.id,
                  titulo: _tituloController.text,
                  preco: double.tryParse(_precoController.text) ?? 0.0,
                );

                if (itemExistente == null) {
                  await _dbService.criar(novaHospedagem); // Cria
                } else {
                  await _dbService.atualizar(novaHospedagem); // Atuailza
                }
                Navigator.pop(context);
              },
              child: Text(itemExistente == null ? 'Adicionar' : 'Salvar Alterações'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Hospedagens'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout(); // Logout
              // Redirecionando para a tela de login
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
      
      // Atualiza a lista automaticamente em tempo real
      body: StreamBuilder<List<Hospedagem>>(
        stream: _dbService.listar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final dados = snapshot.data!;
          if (dados.isEmpty) return const Center(child: Text('Nenhum dado cadastrado.'));

          return ListView.builder(
            itemCount: dados.length,
            itemBuilder: (context, index) {
              final item = dados[index];
              return ListTile(
                title: Text(item.titulo),
                subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}/noite'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => _abrirFormularioModal(itemExistente: item)),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _dbService.deletar(item.id!)), // [D]elete
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormularioModal(),
        child: const Icon(Icons.add),
      ),
    );
  }
}