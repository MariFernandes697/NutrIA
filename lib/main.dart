import 'package:flutter/material.dart';
import 'telas/splash_screen.dart';
import 'telas/login_screen.dart';
import 'telas/recover_password.dart';
import 'telas/signup_screen.dart';
import 'telas/dashboard_screen.dart';

void main() {
  runApp(const NutriAApp());
}

class NutriAApp extends StatelessWidget {
  const NutriAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF27492F),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Open Sans',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const SplashScreen(),
        '/login': (ctx) => const LoginScreen(),
        '/recover': (ctx) => const RecoverPasswordScreen(),
        '/signup': (ctx) => const SignupScreen(),
        '/dashboard': (ctx) => const DashboardScreen(),
      },
    );
  }
}
