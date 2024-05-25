import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/food_selling/login/login.dart';
import 'package:viet_luc63132246_flutter/food_selling/page_food_selling.dart';
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AppFoodSelling();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
