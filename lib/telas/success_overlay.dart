// success_overlay.dart

import 'package:flutter/material.dart';

// Cores de design (consistentes)
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color leafBackgroundOverlay = Color.fromRGBO(
  0,
  0,
  0,
  0.35,
); // Camada escurecida

class SuccessOverlay extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onContinue;

  const SuccessOverlay({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'Início',
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fundo de folhas e Camada escurecida (consistente com Login/Cadastro)
          Positioned.fill(
            child: Image.asset(
              'assets/img/bg-folhas.png', // Sua imagem de fundo
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(child: Container(color: leafBackgroundOverlay)),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO CIRCULAR (consistente)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/img/logo2.png', height: 62),
                    ),

                    const SizedBox(height: 18),

                    // Título (Corresponde à Ação Principal: Cadastrar área, Criar Conta, etc.)
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // --- Cartão Branco de Confirmação ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Mensagem de Sucesso
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Botão de Ação
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: onContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 6,
                              ),
                              child: Text(
                                buttonText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
