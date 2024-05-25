import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/food_selling/login/forgot_password.dart';
import 'package:viet_luc63132246_flutter/food_selling/login/sign_up.dart';
import 'package:viet_luc63132246_flutter/myWidget/custom_text.dart';
import 'package:viet_luc63132246_flutter/widget/snackbar.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail.text,
        password: userPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Tài khoản không tồn tại",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Mật khẩu không đúng",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Đăng Nhập",
                  weight: FontWeight.bold,
                  size: 25,
                ),
                SizedBox(height: 40,),
                TextFormField(
                  controller: userEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: userPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 31,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetPassword(),)
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                        alignment: Alignment.topRight,
                        child: CustomText(
                          text: "Quên Mật khẩu?",
                          size: 18,
                          weight: FontWeight.bold,
                        )
                    ),
                  )
                ),
                SizedBox(height: 50.0,),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                      });
                    }
                    _login();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: CustomText(
                        text: "Đăng Nhập",
                        size: 15,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ),
                ),SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Đăng Ký",
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
