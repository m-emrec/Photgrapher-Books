import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_book/logger.dart';
import 'package:photo_book/screens/home_page.dart';
import 'package:photo_book/screens/login_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          logger.i("Logged in");
          return const HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
