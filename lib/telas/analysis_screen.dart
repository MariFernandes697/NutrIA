// analysis_result_screen.dart

import 'package:flutter/material.dart';

// Cores de design
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color actionColor = Color(
  0xFF1F6A3F,
); // Verde de ação (não usado aqui, mas útil)

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // O fundo da área superior é branco
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor, size: 30),
          onPressed: () {
            // ALTERADO: Volta para o Dashboard, limpando a pilha de navegação
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/dashboard',
              (route) => false,
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Diagnóstico da IA',
          style: TextStyle(
            color: primaryColor, // Título em verde escuro
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      // O corpo principal do conteúdo, abaixo do AppBar, é o verde escuro
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem (Simulando a folha com Oídio)
            _buildImageCard(),
            const SizedBox(height: 10),

            // Texto de Status
            const Center(
              child: Text(
                'Analisando imagem...', // Em um cenário real, seria 'Diagnóstico concluído'
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Título do Diagnóstico
            const Text(
              'Possível diagnóstico',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            // Card do Diagnóstico
            _buildDiagnosisCard(
              title: 'Fungo: Oídio',
              certainty: 90,
              description:
                  'Prejudica a fotossíntese, podendo levar à perda de qualidade e produtividade.',
            ),
            const SizedBox(height: 30),

            // Título da Recomendação
            const Text(
              'Ação recomendada',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            // Card da Recomendação
            _buildRecommendationCard(
              'Aplicar defensivos biológicos. Sugestão: enxofre.',
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets de Componentes ---

  // Card que contém a imagem analisada
  Widget _buildImageCard() {
    return Container(
      height: 200, // Altura ajustada para o exemplo
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        // Placeholder da Imagem (Em produção, seria a imagem real)
        child: Image.network(
          'https://i.imgur.com/gK9x3g0.png', // URL de placeholder que simula a folha com Oídio
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.image, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // Card com o detalhe do diagnóstico
  Widget _buildDiagnosisCard({
    required String title,
    required int certainty,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            '(Certeza da IA: $certainty%)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor.withOpacity(0.8),
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Colors.grey),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Card com a ação recomendada
  Widget _buildRecommendationCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }
}
