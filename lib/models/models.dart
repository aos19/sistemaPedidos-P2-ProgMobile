class Hospedagem {

  final String? id; // ID gerado automaticamente pelo Supabase
  final String titulo;
  final double preco;

  Hospedagem({
    this.id,
    required this.titulo,
    required this.preco,
  });

  // Criando uma instância do modelo a partir de um Map vindo do banco
  factory Hospedagem.fromMap(Map<String, dynamic> map) {

    return Hospedagem(
      id: map['id']?.toString(),
      titulo: map['titulo'] ?? '',
      preco: (map['preco'] as num).toDouble(),
    );
  }

  // Convertendo o modelo para Map para enviar ao banco
  Map<String, dynamic> toMap() {

    final map = <String, dynamic>{
      'titulo': titulo,
      'preco': preco,
    };

    // Só envia o ID se ele existir
    // Isso evita erro no CREATE
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
