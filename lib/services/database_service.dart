// Controla as operações na tabela do banco de dados

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';

class DatabaseService {
  // Garantindo uma instância do cliente
  final _client = Supabase.instance.client.from('hospedagens');

  // Inserir a hospedagem - CREATE
  Future<void> criar(Hospedagem hospedagem) async {
    await _client.insert(hospedagem.toMap());
  }

  // Consulta das hospedagens - READ
  Stream<List<Hospedagem>> listar() {
    return _client.stream(primaryKey: ['id']).map(
      (listaMaps) => listaMaps.map((map) => Hospedagem.fromMap(map)).toList()
    );
  }

  // Atualizar dados já existentes - UPDATE
  Future<void> atualizar(Hospedagem hospedagem) async {
    await _client.update(hospedagem.toMap()).eq('id', hospedagem.id!);
  }

  // Deletar dados - DELETE
  Future<void> deletar(String id) async {
    await _client.delete().eq('id', id);
  }
}