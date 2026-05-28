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

  bool _carregando = false;

  // Atualiza tela manualmente
  void _recarregarTela() {
    setState(() {});
  }

  // Abre modal de criação/edição
  void _abrirFormularioModal({Hospedagem? itemExistente}) {

    if (itemExistente != null) {
      _tituloController.text = itemExistente.titulo;
      _precoController.text = itemExistente.preco.toString();
    } else {
      _tituloController.clear();
      _precoController.clear();
    }

    showModalBottomSheet(

      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) => Padding(

        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 24,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            const Text(
              'Hospedagem',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Nome da Hospedagem',
                prefixIcon: Icon(Icons.hotel_rounded),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _precoController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: 'Preço por Noite',
                prefixIcon: Icon(Icons.attach_money_rounded),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: _carregando
                    ? null
                    : () async {

                        setState(() {
                          _carregando = true;
                        });

                        try {

                          final novaHospedagem = Hospedagem(
                            id: itemExistente?.id,
                            titulo: _tituloController.text,
                            preco: double.tryParse(
                                  _precoController.text,
                                ) ??
                                0.0,
                          );

                          if (itemExistente == null) {

                            await _dbService.criar(
                              novaHospedagem,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Hospedagem adicionada!',
                                ),
                              ),
                            );

                          } else {

                            await _dbService.atualizar(
                              novaHospedagem,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Hospedagem atualizada!',
                                ),
                              ),
                            );
                          }

                          // Atualiza instantaneamente
                          _recarregarTela();

                          Navigator.pop(context);

                        } catch (e) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
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
                      },

                child: _carregando
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        itemExistente == null
                            ? 'Adicionar'
                            : 'Salvar Alterações',
                      ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Deletar hospedagem
  Future<void> _deletarHospedagem(String id) async {

    try {

      await _dbService.deletar(id);

      _recarregarTela();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Hospedagem removida!',
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao deletar: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        toolbarHeight: 80,

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
              'Minhas Hospedagens',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),

        actions: [

          IconButton(

            icon: const Icon(
              Icons.logout,
            ),

            onPressed: () async {

              await _authService.logout();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<List<Hospedagem>>(

        stream: _dbService.listar(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final dados = snapshot.data!;

          if (dados.isEmpty) {

            return const Center(
              child: Text(
                'Nenhuma hospedagem cadastrada.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return RefreshIndicator(

            onRefresh: () async {
              _recarregarTela();
            },

            child: ListView.builder(

              padding: const EdgeInsets.only(
                top: 12,
                bottom: 100,
              ),

              itemCount: dados.length,

              itemBuilder: (context, index) {

                final item = dados[index];

                return Card(

                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: Padding(

                    padding: const EdgeInsets.all(18),

                    child: Row(
                      children: [

                        // Ícone
                        Container(

                          padding:
                              const EdgeInsets.all(14),

                          decoration: BoxDecoration(

                            color: const Color(
                              0xFF0F172A,
                            ).withOpacity(0.08),

                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),

                          child: const Icon(
                            Icons.hotel_rounded,
                            color: Color(0xFF0F172A),
                            size: 32,
                          ),
                        ),

                        const SizedBox(width: 18),

                        // Informações
                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(

                                item.titulo,

                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFF0F172A),
                                ),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [

                                  const Icon(
                                    Icons
                                        .attach_money_rounded,
                                    size: 18,
                                    color: Colors.green,
                                  ),

                                  Text(

                                    'R\$ ${item.preco.toStringAsFixed(2)} / noite',

                                    style:
                                        const TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color(0xFF475569),
                                      fontWeight:
                                          FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Botões
                        Column(
                          children: [

                            IconButton(

                              icon: const Icon(
                                Icons.edit_rounded,
                                color: Colors.orange,
                              ),

                              onPressed: () {

                                _abrirFormularioModal(
                                  itemExistente: item,
                                );
                              },
                            ),

                            IconButton(

                              icon: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                              ),

                              onPressed: () {

                                _deletarHospedagem(
                                  item.id!,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () =>
            _abrirFormularioModal(),

        child: const Icon(Icons.add),
      ),
    );
  }
}