import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vietluc_firebase/Project_AppFoodSelling/page/page_home.dart';
import 'package:vietluc_firebase/Project_AppFoodSelling/signIn_Up/sign_in.dart';

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
            return SignInPage();
          }
        },
      ),
    );
  }
}
