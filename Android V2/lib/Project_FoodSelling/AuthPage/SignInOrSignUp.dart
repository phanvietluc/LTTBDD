import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/signIn_signUp/signIn.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/signIn_signUp/signup.dart';

class SignInOrOut extends StatefulWidget {
  const SignInOrOut({super.key});

  @override
  State<SignInOrOut> createState() => _SignInOrOutState();
}

class _SignInOrOutState extends State<SignInOrOut> {
  bool showPage = true;
  void togglePage(){
    setState(() {
      showPage = !showPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showPage){
      return SignInPage(onPress: togglePage,);
    }else{
      return SignUpPage(onPress: togglePage,);
    }
  }
}
