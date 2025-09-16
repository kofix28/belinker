import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final user = snap.data;
        if (user != null) return const HomePage();
        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _signInWithGoogle() async {
    final provider = GoogleAuthProvider();
    // اختياري: طلب سكوبات إضافية
    // provider.addScope('email');
    await FirebaseAuth.instance.signInWithProvider(provider);
  }

  Future<void> _signInAsGuest() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          FilledButton(
            onPressed: _signInWithGoogle,
            child: const Text('تسجيل دخول Google'),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: _signInAsGuest,
            child: const Text('الدخول كضيف'),
          ),
        ]),
      ),
    );
  }
}
