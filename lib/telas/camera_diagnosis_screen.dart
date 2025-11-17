// camera_diagnosis_screen.dart

import 'package:flutter/material.dart';
import 'analysis_screen.dart';

// Cores de design (consistentes)
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal

class CameraDiagnosisScreen extends StatelessWidget {
  const CameraDiagnosisScreen({super.key});

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
        title: const Text(
          'Aproxime a câmera da\nplanta doente',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primaryColor, // Título em verde escuro
            fontWeight: FontWeight.bold,
            fontSize: 18,
            height: 1.2,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // Calcula a largura da tela para ajustar o tamanho do preview da câmera
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cameraSize = screenWidth * 0.8; // Tamanho do preview

    return Container(
      width: double.infinity,
      // O corpo principal é o verde escuro
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // 1. Área de Preview da Câmera (simulada)
          _buildCameraPreview(cameraSize),

          const Spacer(), // Empurra o botão para baixo
          // 2. Botão de Captura
          _buildCaptureButton(context),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // --- Widgets de Componentes ---

  // 1a. Widget para a área de visualização da câmera
  Widget _buildCameraPreview(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: primaryColor, // Fundo do container é verde
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white70, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          // Placeholder para simular o preview de câmera com a folha doente
          'https://i.imgur.com/gK9x3g0.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.videocam_off, size: 60, color: Colors.white70),
          ),
        ),
      ),
    );
  }

  // 2a. Widget para o botão de captura (grande e estilizado)
  Widget _buildCaptureButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // ALTERADO: Após a captura, navega para a tela de resultado
        Navigator.pushReplacement(
          // Usamos Replacement para que o botão Voltar saia da câmera
          context,
          MaterialPageRoute(builder: (context) => const AnalysisResultScreen()),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        // Adicionando um ícone estilizado que se assemelha ao design (um scanner)
        child: const Icon(
          Icons.camera_alt, // Ícone da câmera
          color: primaryColor,
          size: 50,
        ),
        // Para simular a moldura de scanner do design:
        // Se quisermos o ícone de scanner como no design, podemos usar um Stack com bordas
        // No momento, usarei o ícone de câmera padrão do Flutter que é mais fácil de estilizar.
      ),
    );
  }
}
