import 'package:flutter/material.dart';
import 'success_overlay.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  // 1. Definição dos FocusNodes para rastrear o foco do campo
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _obscurePassword = true;
  // ignore: unused_field
  String _name = '', _email = '', _password = '';

  // Cores de design
  static const Color primaryColor = Color(
    0xFF27492F,
  ); // Verde escuro para o botão
  static const Color accentBorderColor = Color(
    0xFFB3E5FC,
  ); // Azul claro/Brilhante

  @override
  void initState() {
    super.initState();
    // 2. Adiciona listeners para forçar o redesenho (setState) quando o foco muda
    _nameFocus.addListener(_onFocusChange);
    _emailFocus.addListener(_onFocusChange);
    _passwordFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {}); // Força o widget a redesenhar para atualizar as bordas
  }

  // trecho do signup_screen.dart

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      debugPrint('Cadastrando: Nome: $_name, Email: $_email');

      // ALTERADO: Navega para a tela de Sucesso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessOverlay(
            title: 'Criar Conta',
            message: 'Conta criada com sucesso!',
            onContinue: () {
              // Navega para o Dashboard (fluxo normal após login/cadastro)
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
  // ...

  // 4. Implementa a limpeza dos FocusNodes
  @override
  void dispose() {
    _passwordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // Widget utilitário para criar os TextFields estilizados (agora recebe FocusNode)
  Widget _buildTextField({
    required String hintText,
    required FocusNode focusNode, // Recebe o FocusNode
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    // 3. Define as cores da borda condicionalmente
    final Color borderColor = focusNode.hasFocus
        ? accentBorderColor
        : Colors.white;
    final double borderWidth = focusNode.hasFocus ? 2.5 : 1.0;

    return Container(
      // Padding lateral para centralizar o bloco de campos
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 50, // Altura padronizada para campos grandes
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: borderColor, // Borda agora é condicional
            width: borderWidth, // Largura agora é condicional
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.2), // Sombra suave
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          focusNode: focusNode, // Aplica o FocusNode
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword ? _obscurePassword : false,
          onSaved: onSaved,
          validator: validator,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color.fromARGB(255, 116, 116, 116),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),

            // Botão de visibilidade apenas para campo de senha
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: primaryColor.withOpacity(0.8),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Para o fundo de folha ir até o topo do Scaffold
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
          // Fundo de folhas (imagem - consistência de design)
          Positioned.fill(
            child: Image.asset(
              'assets/img/bg-folhas.png', // Sua imagem de fundo
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // LOGO CIRCULAR (mantendo o estilo da tela de login)
                  // Logo centralizado circular (opcional background)
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/img/logo2.png',
                            height: 62,
                          ),
                        ),
                        // Camada escurecida suave (para melhorar contraste)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.35),
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Título
                  const Text(
                    'Criar Conta',
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

                  // --- Formulário ---
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Campo Nome
                        _buildTextField(
                          hintText: 'Nome',
                          focusNode: _nameFocus, // Aplica o FocusNode
                          keyboardType: TextInputType.name,
                          onSaved: (v) => _name = v ?? '',
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Informe seu nome'
                              : null,
                        ),

                        // Campo E-mail
                        _buildTextField(
                          hintText: 'Email',
                          focusNode: _emailFocus, // Aplica o FocusNode
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (v) => _email = v ?? '',
                          validator: (v) {
                            if (v == null || v.isEmpty || !v.contains('@')) {
                              return 'Informe um e-mail válido';
                            }
                            return null;
                          },
                        ),

                        // Campo Definir Senha
                        _buildTextField(
                          hintText: 'Definir Senha',
                          focusNode: _passwordFocus, // Aplica o FocusNode
                          isPassword: true,
                          controller: _passwordController,
                          onSaved: (v) => _password = v ?? '',
                          validator: (v) => (v == null || v.length < 6)
                              ? 'A senha deve ter pelo menos 6 caracteres'
                              : null,
                        ),

                        const SizedBox(height: 18),

                        // Botão Cadastrar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 8,
                              ),
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
