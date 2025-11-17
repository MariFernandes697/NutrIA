// profile_screen.dart

import 'package:flutter/material.dart';

// Importe as rotas ou o componente de sucesso se necessário, por enquanto apenas cores
// Lembre-se de importar o recovery_password_screen para a funcionalidade de redefinir senha

// Cores de design
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color alertColor = Color(0xFFE53935); // Cor de alerta (Vermelho para Sair)

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Dados mockados
  final String userName = 'João Agricultor';
  final String userEmail = 'joao.agricola@nutria.com';
  final String userPhone = '(11) 98765-4321';
  
  // Lista de informações para exibir
  List<Map<String, String>> get _profileInfo => [
    {'title': 'Nome', 'value': userName},
    {'title': 'Email', 'value': userEmail},
    {'title': 'Telefone', 'value': userPhone},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // O Dashboard já cuida do AppBar e da navegação, mas se fosse uma tela separada:
        // leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            color: primaryColor,
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
      decoration: const BoxDecoration(
        color: primaryColor, // O corpo principal é o verde escuro
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar do Usuário
            _buildUserAvatar(),
            const SizedBox(height: 30),

            // Card com Informações do Usuário
            _buildInfoCard(),
            const SizedBox(height: 30),

            // Botão de Redefinir Senha (Se for separado das Configurações)
            _buildResetPasswordButton(context),
            const SizedBox(height: 30),
            
            // Botão Sair (Logout)
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // --- Widgets de Componentes ---

  // Avatar
  Widget _buildUserAvatar() {
    return const CircleAvatar(
      radius: 60,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        size: 80,
        color: primaryColor,
      ),
    );
  }

  // Card de Informações
  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
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
        children: _profileInfo.map((item) => _buildProfileItem(item['title']!, item['value']!)).toList(),
      ),
    );
  }

  // Item individual de informação
  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (title != _profileInfo.last['title']) 
            const Divider(height: 20, thickness: 1, indent: 0, endIndent: 0, color: Color(0xFFF0F0F0)),
        ],
      ),
    );
  }

  // Botão Redefinir Senha
  Widget _buildResetPasswordButton(BuildContext context) {
    // Note: Usamos o ResetPasswordScreen que já criamos
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          // TODO: Ligar ao ResetPasswordScreen
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
          debugPrint('Navegar para Redefinir Senha');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Redefinir Senha',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  
  // Botão Sair (Logout)
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Simular Logout e voltar para a tela de Login
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: alertColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 6,
        ),
        child: const Text(
          'Sair',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}