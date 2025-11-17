// settings_screen.dart

import 'package:flutter/material.dart';
import 'reset_password_screen.dart';

// Cores de design (consistentes)
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color alertColor = Color(0xFFE53935); // Cor de alerta (Vermelho)
const Color safeColor = Color(
  0xFF43A047,
); // Cor de status saudável (Verde forte)
const Color accentColor = Color(0xFFF0F0F0); // Cor de fundo suave dos itens

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          'Configurações',
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
      // O corpo principal do conteúdo, abaixo do AppBar, é o verde escuro
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Sistema e Hardware
            _buildSectionTitle('Sistema e Hardware'),
            _buildToggleItem(
              title: 'Dispositivos IoT',
              value: true, // Mocked: ligado
              onChanged: (v) => debugPrint('IoT Toggled: $v'),
            ),
            const SizedBox(height: 30),

            // 2. Preferências
            _buildSectionTitle('Preferências'),
            _buildToggleItem(
              title: 'Notificações',
              value: true, // Mocked: ligado
              onChanged: (v) => debugPrint('Notificações Toggled: $v'),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.white70),
            _buildActionItem(
              title: 'Tema',
              icon: Icons.light_mode, // Simula o ícone de brilho
              onTap: () => debugPrint('Mudar Tema'),
            ),
            const SizedBox(height: 30),

            // 3. Minha conta (Usamos um card que simula os campos estáticos/ações)
            _buildSectionTitle('Minha conta'),
            _buildAccountCard(context),
            const SizedBox(height: 40),

            // 4. Botão Sair
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // --- Widgets de Componentes ---

  // Título da Seção
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 15.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Item de Configuração com Toggle
  Widget _buildToggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: safeColor,
            inactiveThumbColor: primaryColor,
            inactiveTrackColor: primaryColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  // Item de Configuração com Ação (Tema)
  Widget _buildActionItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(icon, color: primaryColor),
      ),
    );
  }

  // Card com as informações de Conta
  Widget _buildAccountCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // 3a. Nome (Campo estático)
          _buildAccountItem(
            title: 'Nome',
            value: 'Usuário NutriA',
            isAction: false,
          ),
          const Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: accentColor,
          ),
          // 3b. Email (Campo estático)
          _buildAccountItem(
            title: 'Email',
            value: 'usuario@nutria.com',
            isAction: false,
          ),
          const Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: accentColor,
          ),
          // 3c. Redefinir Senha (Ação)
          _buildAccountItem(
            title: 'Redefinir senha',
            value: '',
            isAction: true,
            onTap: () {
              // ALTERADO: Lógica de Navegação
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Item genérico dentro do Card de Conta
  Widget _buildAccountItem({
    required String title,
    required String value,
    required bool isAction,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: isAction ? onTap : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isAction ? primaryColor : Colors.grey,
        ),
      ),
      subtitle: isAction
          ? null
          : Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
      trailing: isAction
          ? const Icon(Icons.chevron_right, color: primaryColor)
          : null,
    );
  }

  // Botão Sair (Logout)
  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            // Lógica de Logout
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
            elevation: 8,
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
      ),
    );
  }
}
