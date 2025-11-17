import 'package:flutter/material.dart';
import 'camera_diagnosis_screen.dart';
import 'area_detail_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'register_area_screen.dart';

// Cores de design (consistentes com as outras telas)
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color secondaryColor = Color(0xFF4CAF50); // Verde um pouco mais claro
const Color alertColor = Color(0xFFFFA000); // Amarelo/Laranja para alertas
const Color safeColor = Color(0xFF43A047); // Verde forte para status saudável

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // Índice da aba selecionada (inicia em Home)

  // Lista de Widgets (Telas/Abas) para o BottomNavigationBar
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      // O botão de "Adicionar" é o item de índice 2 (terceiro item).
      if (index == 2) {
        _showAddActionSheet(context);
      } else {
        // Mapeamento: Se o índice for 3 (Perfil), mapeia para 2 na lista de widgets.
        _selectedIndex = index > 2 ? index - 1 : index;
      }
    });
  }

  // Função para simular o clique no botão '+'
  void _showAddActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add_location_alt, color: primaryColor),
              title: const Text('Cadastrar Nova Área'),
              onTap: () {
                Navigator.pop(context);
                // Navegação para a tela de Cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterAreaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: primaryColor),
              title: const Text('Realizar Análise'),
              onTap: () {
                Navigator.pop(context);
                // Navegação para a tela da Câmera
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraDiagnosisScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Fundo principal branco
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(''), // Título vazio
        centerTitle: true,
        actions: const [], // Ícones removidos
      ),

      // Corpo da tela (o conteúdo da aba selecionada)
      body: _widgetOptions.elementAt(_selectedIndex),

      // Barra de navegação inferior
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Início',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Config',
              ),
              // Botão de Ação (Aba no índice 2)
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline, size: 30),
                activeIcon: Icon(Icons.add_circle, size: 30),
                label: 'Add',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            // Ajuste do currentIndex
            currentIndex: _selectedIndex > 1 ? 0 : _selectedIndex,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

// --- Telas de Conteúdo (Implementação da HOME SCREEN) ---

class Area {
  final String name;
  final String assetPath;
  final bool hasAlert;

  Area({required this.name, required this.assetPath, this.hasAlert = false});
}

// CORREÇÃO: HomeScreen transformada em StatefulWidget para acesso ao BuildContext (navegação).
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Area> areas = [
    Area(
      name: 'Horta de Tomates',
      assetPath: 'assets/img/tomates.png',
      hasAlert: true,
    ),
    Area(
      name: 'Horta Alfaces',
      assetPath: 'assets/img/tomates.png',
      hasAlert: false,
    ),
    Area(
      name: 'Pomar de Maçãs',
      assetPath: 'assets/img/tomates.png',
      hasAlert: false,
    ),
  ];

  // Cartão estilizado para métricas e listas
  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  // Linha de Status
  Widget _buildStatusRow({required String text, required bool isAlert}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            isAlert ? Icons.warning : Icons.check_circle,
            color: isAlert ? alertColor : safeColor,
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: isAlert ? alertColor : primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Item da Lista de Áreas
  Widget _buildAreaItem(Area area) {
    return InkWell(
      onTap: () {
        // Navegação para a Tela de Detalhes da Área
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AreaDetailScreen(areaName: area.name),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Imagem do Asset (usando o novo assetPath)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                area.assetPath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                area.name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (area.hasAlert)
              const Icon(Icons.error, color: alertColor, size: 24),
            const Icon(Icons.chevron_right, color: Colors.white70, size: 28),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding superior para criar o "recuo" do canto do AppBar
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: primaryColor, // Fundo VERDE ESCURO
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Cartão Status Geral
            _buildCard(
              title: 'Status Geral',
              child: Column(
                children: [
                  _buildStatusRow(text: '2 Áreas saudáveis', isAlert: false),
                  _buildStatusRow(text: '1 Área com alerta', isAlert: true),
                ],
              ),
            ),

            // Cartão Áreas Cadastradas
            _buildCard(
              title: 'Áreas cadastradas',
              child: Column(
                children: [
                  ...areas
                      .map(
                        (area) => Column(
                          children: [
                            _buildAreaItem(area),
                            if (area != areas.last)
                              const Divider(height: 1, color: Colors.white70),
                          ],
                        ),
                      )
                      .toList(),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
