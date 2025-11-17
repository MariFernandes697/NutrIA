import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Logo central (use assets/img/logo.png)
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/logo2.png',
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/img/logo.png',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // Botão "Começar" grande, arredondado, com sombra
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F6A3F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black26,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Começar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
