// area_detail_screen.dart

import 'package:flutter/material.dart';
import 'camera_diagnosis_screen.dart'; // Importe a tela de câmera

// Cores de design
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color alertColor = Color(0xFFE53935); // Cor de alerta (Vermelho)
const Color safeColor = Color(
  0xFF43A047,
); // Cor de status saudável (Verde forte)
const Color textColor = Color(0xFF424242); // Cor de texto cinza escuro
const Color fabColor = Color(0xFF4CAF50); // Cor para o FAB (Verde vibrante)

// Modelo de dados mockado para o sensor
class SensorData {
  final IconData icon;
  final String title;
  final String value;
  final bool isAlert;
  final Color statusColor;

  const SensorData({
    required this.icon,
    required this.title,
    required this.value,
    this.isAlert = false,
    this.statusColor = primaryColor,
  });
}

class AreaDetailScreen extends StatelessWidget {
  final String areaName;

  const AreaDetailScreen({super.key, required this.areaName});

  // Dados mockados dos sensores
  final List<SensorData> sensors = const [
    SensorData(
      icon: Icons.water_drop_outlined,
      title: 'Umidade do solo',
      value: '45%',
      statusColor: primaryColor,
    ),
    SensorData(
      icon: Icons.wb_sunny_outlined,
      title: 'Intensidade de luz',
      value: '80%',
      statusColor: primaryColor,
    ),
    SensorData(
      icon: Icons.bug_report_outlined,
      title: 'Possíveis pragas',
      value: 'Verifique sua horta!',
      isAlert: true,
      statusColor: alertColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco na área do AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          areaName, // Título dinâmico (Ex: Horta Tomates)
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: _buildBody(context),

      // NOVO: Floating Action Button para iniciar a análise
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica de navegação para a tela da câmera
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraDiagnosisScreen(),
            ),
          );
        },
        label: const Text(
          'Realizar Análise',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: fabColor,
        elevation: 8,
      ),
      // Posiciona o FAB na parte inferior central
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor, // O corpo principal é o verde escuro
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        // Adicionamos um padding extra na parte inferior para o conteúdo não ficar atrás do FAB
        padding: const EdgeInsets.only(top: 25.0, bottom: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem da Área
            _buildAreaImage(),
            const SizedBox(height: 30),

            // Título Sensores
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Sensores',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Lista de Cartões de Sensores
            ...sensors
                .map((sensor) => _buildSensorCard(sensor, context))
                .toList(),
          ],
        ),
      ),
    );
  }

  // Imagem da Área
  Widget _buildAreaImage() {
    return Center(
      child: Container(
        height: 200,
        width: 350, // Tamanho ligeiramente menor que a largura total
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://i.imgur.com/vH9zR2t.jpeg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.park, size: 60, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  // Card de Status do Sensor
  Widget _buildSensorCard(SensorData data, BuildContext context) {
    final Widget chartPlaceholder = Icon(
      Icons.show_chart,
      color: data.statusColor.withOpacity(0.7),
      size: 40,
    );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(data.icon, color: primaryColor, size: 28),
              const SizedBox(width: 10),
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.value,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: data.statusColor,
                ),
              ),
              chartPlaceholder,
            ],
          ),
        ],
      ),
    );
  }
}
