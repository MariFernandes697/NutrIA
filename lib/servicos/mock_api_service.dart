// lib/services/mock_api_service.dart
import 'dart:async';
import '../modelos/structDatas.dart';

class Diagnostico {
  final String titulo;
  final String descricao;
  final double confianca;

  Diagnostico({
    required this.titulo,
    required this.descricao,
    required this.confianca,
  });

  @override
  String toString() =>
      '$titulo (${(confianca * 100).toStringAsFixed(0)}%): $descricao';
}

class MockApiService {
  // dados em memória
  final List<Structdatas> _datas = [
    Structdatas(id: 1, nome: 'Jardim Frontal', umidade: 70),
    Structdatas(id: 2, nome: 'Horta', umidade: 40),
    Structdatas(id: 3, nome: 'Área Lateral', umidade: 25),
  ];

  // Simula um GET /api/zonas
  Future<List<Structdatas>> fetchDatas() async {
    await Future.delayed(Duration(milliseconds: 400)); // latência simulada
    // devolve cópia para evitar mutações externas diretas
    return _datas
        .map(
          (d) => Structdatas(
            id: d.id,
            nome: d.nome,
            umidade: d.umidade,
            irrigando: d.irrigando,
            status: d.status,
          ),
        )
        .toList();
  }

  // Simula POST /api/diagnostico (envio de imagem para CNN)
  Future<Diagnostico> runDiagnostico() async {
    await Future.delayed(Duration(seconds: 2)); // tempo de inferência
    // resposta simulada
    return Diagnostico(
      titulo: 'Deficiência de Nitrogênio',
      descricao:
          'Sugere aplicar Solução N-10 nos próximos 3 ciclos de irrigação.',
      confianca: 0.92,
    );
  }

  // Simula comando para ativar tratamento (válvula/bomba)
  Future<void> ativarTratamento(String dataNome) async {
    await Future.delayed(Duration(milliseconds: 300));
    final d = _datas.firstWhere(
      (x) => x.nome == dataNome,
      orElse: () => throw 'Zona não encontrada',
    );
    d.irrigando = true;
    d.status = 'Irrigando...';
    // Simula aumento de umidade ao longo do tempo
    Timer.periodic(Duration(milliseconds: 500), (t) {
      d.umidade = (d.umidade + 5).clamp(0, 100);
      if (d.umidade >= 60) {
        d.irrigando = false;
        d.status = 'Normal';
        t.cancel();
      }
    });
  }

  // Simula parar irrigação
  Future<void> pararTratamento(String dataNome) async {
    await Future.delayed(Duration(milliseconds: 200));
    final d = _datas.firstWhere(
      (x) => x.nome == dataNome,
      orElse: () => throw 'Zona não encontrada',
    );
    d.irrigando = false;
    d.status = 'Normal';
  }
}
