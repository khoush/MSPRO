import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nom_du_projet/screens/statistic.dart';
import 'package:nom_du_projet/screens/welcome_screen.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return StatPage();
          }

          // user is NOT logged in
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}