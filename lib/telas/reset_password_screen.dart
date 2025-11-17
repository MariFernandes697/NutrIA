// reset_password_screen.dart

import 'package:flutter/material.dart';
import 'success_overlay.dart';

// Cores de design (consistentes)
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color accentColor = Color(0xFFF0F0F0); // Cor de fundo suave dos campos
const Color leafBackgroundOverlay = Color.fromRGBO(
  0,
  0,
  0,
  0.35,
); // Camada escurecida

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controles de visibilidade para cada campo de senha
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // FUNÇÃO DE SUBMISSÃO CORRIGIDA: Limpa e funcional.
  void _submit() {
    // 1. Validação do formulário
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Lógica para redefinir a senha (API call, etc.)
      debugPrint('Tentativa de redefinição de senha...');

      // 2. Navegação para a tela de Sucesso usando o componente reutilizável
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessOverlay(
            title: 'Redefinir Senha',
            message: 'Senha redefinida com sucesso!',
            onContinue: () {
              // Navega de volta para o Dashboard, limpando a pilha de navegação.
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/dashboard',
                (route) => false,
              );
            },
          ),
        ),
      );
    }
  }

  // Widget utilitário para criar os campos de senha
  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required bool obscureText,
    required Function(bool) toggleObscure,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: accentColor, // Fundo cinza claro
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF757575)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: primaryColor.withOpacity(0.8),
                ),
                onPressed: () => toggleObscure(!obscureText),
              ),
            ),
            validator: (v) {
              if (v == null || v.length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              // OBSERVAÇÃO: Em uma aplicação real, você também validaria
              // se a Nova Senha e a Confirmação de Senha são iguais aqui.
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Controladores de texto mockados (em uma aplicação real seriam gerenciados)
    // OBS: Em um StatefullWidget, estas controllers devem ser movidas para o State
    // e inicializadas/disposed, mas para o MVP vamos mantê-las aqui:
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Fundo de folhas e Camada escurecida
          Positioned.fill(
            child: Image.asset('assets/img/bg-folhas.png', fit: BoxFit.cover),
          ),
          Positioned.fill(child: Container(color: leafBackgroundOverlay)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

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

                  // Título
                  const Text(
                    'Redefinir senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // --- Cartão Branco do Formulário ---
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 1. Senha Atual
                            _buildPasswordField(
                              label: 'Digite sua senha atual',
                              hintText: 'Senha atual',
                              obscureText: _obscureCurrent,
                              toggleObscure: (v) =>
                                  setState(() => _obscureCurrent = v),
                              controller: currentPasswordController,
                            ),

                            // 2. Nova Senha
                            _buildPasswordField(
                              label: 'Digite sua nova senha',
                              hintText: 'Nova senha',
                              obscureText: _obscureNew,
                              toggleObscure: (v) =>
                                  setState(() => _obscureNew = v),
                              controller: newPasswordController,
                            ),

                            // 3. Confirmação
                            _buildPasswordField(
                              label: 'Confirme a nova senha',
                              hintText: 'Nova senha',
                              obscureText: _obscureConfirm,
                              toggleObscure: (v) =>
                                  setState(() => _obscureConfirm = v),
                              controller: confirmPasswordController,
                            ),

                            const SizedBox(height: 10),

                            // Botão Redefinir
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 6,
                                ),
                                child: const Text(
                                  'Redefinir',
                                  style: TextStyle(
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
                    ),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
