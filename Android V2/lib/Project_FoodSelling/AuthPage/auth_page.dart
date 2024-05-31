import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SignInOrSignUp.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/Page/page_food_selling.dart';

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
            return SignInOrOut();
          }
        },
      ),
    );
  }
}
