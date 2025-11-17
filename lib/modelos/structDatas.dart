// lib/models/zona.dart

class Structdatas {
  final int id;
  final String nome;
  double umidade;
  bool irrigando;
  String status;

  Structdatas({
    required this.id,
    required this.nome,
    required this.umidade,
    this.irrigando = false,
    this.status = "Normal",
  });

  // Método que irá simula leitura de sensor
  void atualizarUmidade(double novaUmidade) {
    umidade = novaUmidade;
    status = novaUmidade < 30
        ? "Crítico (Baixa Umidade)"
        : novaUmidade < 50
        ? "Atenção"
        : "Normal";
  }

  // Método que simula ativação de irrigação
  void ativarIrrigacao() {
    irrigando = true;
    status = "Irrigando...";
  }

  void pararIrrigacao() {
    irrigando = false;
    status = "Normal";
  }

  // Método auxiliar para converter em texto legível
  @override
  String toString() {
    return 'Structdatas(id: $id, nome: $nome, umidade: $umidade%, status: $status)';
  }
}
