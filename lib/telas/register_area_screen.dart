// register_area_screen.dart

import 'package:flutter/material.dart';
import 'success_overlay.dart'; // Para a navegação de sucesso

// Cores de design
const Color primaryColor = Color(0xFF1B5E20); // Verde escuro principal
const Color saveButtonColor = Color(0xFFE53935); // Cor do botão Salvar (Vermelho)
const Color accentColor = Color(0xFFF0F0F0); // Cor de fundo suave dos campos

// ALTERADO: Convertido para StatefulWidget para usar GlobalKey e estado.
class RegisterAreaScreen extends StatefulWidget {
  const RegisterAreaScreen({super.key});

  @override
  State<RegisterAreaScreen> createState() => _RegisterAreaScreenState();
}

class _RegisterAreaScreenState extends State<RegisterAreaScreen> {
  // 1. CHAVE DO FORMULÁRIO: Identificador para validar e salvar o formulário
  final _formKey = GlobalKey<FormState>(); 
  
  // Variáveis para armazenar os dados do formulário
  String? _areaName;
  String? _areaCulture;
  String? _iotDeviceID;

  // 2. FUNÇÃO DE SUBMISSÃO: Valida e navega
  void _submit() {
    // 2.1 Tenta validar todos os campos do formulário
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // 2.2 Salva os valores nas variáveis
      
      debugPrint('Área Cadastrada: Nome: $_areaName, Cultura: $_areaCulture, IoT: $_iotDeviceID');

      // 2.3 Navegação para a tela de Sucesso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessOverlay(
            title: 'Cadastrar Área',
            message: 'Nova área cadastrada com sucesso!',
            onContinue: () {
              // Volta para o Dashboard
              Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
            },
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Cadastrar Área',
          style: TextStyle(
            color: Colors.white,
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
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        
        // 3. WIDGET FORM: Envolve os campos
        child: Form(
          key: _formKey, // Atribuição da chave
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 4. Campos do Formulário (Usando o novo Widget que aceita validação)

              // Campo N° do sensor (Mantido o nome original do design, mas implementado como texto)
              _buildTextField(
                hintText: 'N° do sensor',
                onSaved: (value) => _iotDeviceID = value, 
                validator: (value) => value!.isEmpty ? 'O número do sensor é obrigatório.' : null, // Tornando obrigatório
              ),
              
              // Campo Localização (Localização física)
              _buildTextField(
                hintText: 'Localização',
                onSaved: (value) => _areaName = value, 
                validator: (value) => value!.isEmpty ? 'A localização é obrigatória.' : null, // Tornando obrigatório
              ),
              
              // Campo Quais plantas? (Cultura)
              _buildTextField(
                hintText: 'Quais plantas?',
                onSaved: (value) => _areaCulture = value, 
                validator: (value) => value!.isEmpty ? 'O tipo de planta é obrigatório.' : null, // Tornando obrigatório
              ),

              // Campo Tamanho aproximado (opcional)
              _buildTextField(
                hintText: 'Tamanho aproximado',
                onSaved: (value) => {}, // Não precisa salvar, se não for obrigatório
                validator: null, 
              ),
              
              // Campo de Foto (Reutilizando a estrutura anterior)
              _buildPhotoField(hint: 'Foto da área (opcional)'),

              const SizedBox(height: 40),

              // 5. BOTÃO SALVAR (Chama _submit)
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets de Componentes ---

  // 4a. Widget para campos de texto padronizados (AGORA É UM TextFormField)
  Widget _buildTextField({
    required String hintText,
    required FormFieldSetter<String?> onSaved,
    required FormFieldValidator<String?>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: accentColor, 
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: TextFormField( // Usando TextFormField para validação
          onSaved: onSaved, // Recebe a função para salvar o estado
          validator: validator, // Recebe a função para validar
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            border: InputBorder.none,
            errorStyle: const TextStyle(height: 0, fontSize: 0), // Esconde a mensagem de erro
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  // Widget para o campo de Foto (sem alterações na estrutura)
  Widget _buildPhotoField({required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: InkWell(
          onTap: () {
            debugPrint('Abrir seleção de foto ou câmera.');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
                Icon(Icons.image_outlined, color: primaryColor, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // 5a. Widget para o botão de salvar
  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submit, // Chama a função que faz a validação
        style: ElevatedButton.styleFrom(
          backgroundColor: saveButtonColor, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 10,
          shadowColor: saveButtonColor.withOpacity(0.5),
        ),
        child: const Text(
          'Salvar',
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