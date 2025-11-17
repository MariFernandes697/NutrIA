import 'package:flutter/material.dart';
import 'success_overlay.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  String _email = '';

  // Cores de design (consistentes com as outras telas)
  static const Color primaryColor = Color(
    0xFF1B5E20,
  ); // Verde escuro para o botão
  static const Color accentBorderColor = Color(
    0xFFB3E5FC,
  ); // Azul claro/Brilhante

  @override
  void initState() {
    super.initState();
    // Listener para aplicar a borda azul no campo quando estiver focado
    _emailFocus.addListener(() => setState(() {}));
  }

  // FUNÇÃO CORRIGIDA E LIMPA
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      debugPrint('Solicitando recuperação de senha para: $_email');

      // ALTERADO: Substitui o diálogo por navegação para SuccessOverlay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessOverlay(
            title: 'Email de recuperação enviado!',
            message:
                'Verifique seu e-mail e spam para encontrar o link de redefinição.',
            onContinue: () {
              // Volta para a tela de Login, removendo a tela de recuperação
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ),
      );
    }
  }

  // 4. Implementa a limpeza dos FocusNodes
  @override
  void dispose() {
    _emailFocus.dispose();
    super.dispose();
  }

  // Widget para criar o campo de email no estilo do cartão
  Widget _buildEmailField() {
    // Borda condicional para o campo de email dentro do cartão
    final Color borderColor = _emailFocus.hasFocus
        ? accentBorderColor
        : Colors.transparent;
    final double borderWidth = _emailFocus.hasFocus ? 2.0 : 0;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(
          0xFFE0E0E0,
        ), // Fundo cinza claro do campo (como no design)
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor, // Borda condicional
          width: borderWidth,
        ),
      ),
      child: TextFormField(
        focusNode: _emailFocus,
        keyboardType: TextInputType.emailAddress,
        onSaved: (v) => _email = v ?? '',
        validator: (v) {
          if (v == null || v.isEmpty || !v.contains('@')) {
            return 'Informe um e-mail válido';
          }
          return null;
        },
        style: const TextStyle(fontSize: 18),
        decoration: const InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Color(0xFF757575)), // Cinza mais escuro
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Ícone de voltar na cor branca
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Fundo de folhas (imagem)
          Positioned.fill(
            child: Image.asset('assets/img/bg-folhas.png', fit: BoxFit.cover),
          ),

          // Camada escurecida suave
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          SafeArea(
            child: SingleChildScrollView(
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

                  const SizedBox(height: 20),

                  // Título
                  const Text(
                    'Recuperar senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- Cartão Branco do Formulário ---
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                            const Text(
                              'Digite seu email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF424242),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Campo Email
                            _buildEmailField(),

                            const SizedBox(height: 20),

                            // Botão Enviar
                            SizedBox(
                              width: double.infinity,
                              height: 46,
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
                                  'Enviar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
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

                  const SizedBox(height: 139),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}