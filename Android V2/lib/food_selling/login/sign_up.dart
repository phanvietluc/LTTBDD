import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/food_selling/login/login.dart';
import 'package:viet_luc63132246_flutter/myWidget/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final _formkey = GlobalKey<FormState>();
  void _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail.text,
        password: userPassword.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName.text);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        setState(() {
          this.user = user;
        });
      }
      Navigator.pop(context, user);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "Mật khẩu quá yếu",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            )));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "Tài khoản đã tồn tại",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          key: _formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Đăng Ký",
                  weight: FontWeight.bold,
                  size: 25,
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: userName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Tên",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: userEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập Email';
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
                SizedBox(height: 50.0,),
                GestureDetector(
                  onTap: () async{
                    if(_formkey.currentState!.validate()){
                      setState(() {
                      });
                    }
                    _signUp();
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
                          text: "Đăng Ký",
                          size: 15,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                  ),
                ),SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Đăng Nhập",
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
