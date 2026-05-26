class Hospedagem {
  final String? id; // ID gerado pelo Supabase
  final String titulo;
  final double preco;

  Hospedagem({this.id, required this.titulo, required this.preco});

   // Criando uma instância do modelo a partir de um mapa (Map) vindo do banco
  factory Hospedagem.fromMap(Map<String, dynamic> map) {
    return Hospedagem(
      id: map['id'],
      titulo: map['titulo'],
      preco: map['preco'],
    );
}

  // Convertendo o modelo para um mapa (Map) para enviar ao banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'preco': preco,
    };
  }
}