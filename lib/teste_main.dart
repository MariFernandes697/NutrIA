import 'dart:async';
// ignore: unused_import
import 'modelos/structDatas.dart';
import 'servicos/mock_api_service.dart';

Future<void> main() async {
  final api = MockApiService();

  print('--- Zonas ---');
  final datas = await api.fetchDatas();
  datas.forEach((d) => print(d));

  print('\n--- Rodando diagnóstico (simulado) ---');
  final diag = await api.runDiagnostico();
  print(diag);

  print('\n--- Ativando tratamento na Horta (simulado) ---');
  await api.ativarTratamento('Horta');

  // Para observar as mudanças de umidade, vamos imprimir o status por alguns segundos
  final subs = Timer.periodic(Duration(milliseconds: 700), (t) async {
    final current = (await api.fetchDatas()).firstWhere(
      (d) => d.nome == 'Horta',
    );
    print(
      'Horta -> umidade: ${current.umidade.toStringAsFixed(0)}%, irrigando: ${current.irrigando}, status: ${current.status}',
    );
    if (current.umidade >= 60) {
      t.cancel();
      print('--- Tratamento finalizado ---');
    }
  });

  // espera a finalização do timer (máx 10s)
  await Future.delayed(Duration(seconds: 10));
  subs.cancel();
  print('\nFim da simulação.');
}
