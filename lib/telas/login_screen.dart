import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  String email = '', password = '';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // no protótipo, navega direto ao dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    const Color primary = Color(0xFF27492F);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fundo de folhas (imagem)
          Positioned.fill(
            child: Image.asset(
              'assets/img/bg-folhas.png', // sua imagem de fundo
              fit: BoxFit.cover,
            ),
          ),

          // Camada escurecida suave para melhorar contraste dos campos
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.18)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
              child: Column(
                children: [
                  const SizedBox(height: 18),

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
                            height: 82,
                          ),
                        ),
                         // Camada escurecida suave (para melhorar contraste)
                        Positioned.fill(
                          child: Container(color: Colors.black.withOpacity(0.35)),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),

                  // Formulário - campos brancos arredondados com sombra suave
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Usuário
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            onSaved: (v) => email = v ?? '',
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Informe seu usuário'
                                : null,
                            decoration: const InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Senha
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            obscureText: _obscure,
                            onSaved: (v) => password = v ?? '',
                            validator: (v) => (v == null || v.length < 4)
                                ? 'Senha muito curta'
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Botão Entrar verde
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                54,
                                117,
                                69,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 6,
                            ),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Esqueceu senha
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/recover'),
                          child: const Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Novo por aqui? Criar conta
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Novo por aqui?',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signup'),
                              child: const Text(
                                'Criar conta',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 66),
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
