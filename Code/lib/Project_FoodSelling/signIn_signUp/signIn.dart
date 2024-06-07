import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/signIn_signUp/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInPage extends StatefulWidget {
  final Function()? onPress;
  const SignInPage({super.key, required this.onPress});

  @override
  State<SignInPage> createState() => _SignInPageState();
}
final _formKey = GlobalKey<FormState>();
String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
class _SignInPageState extends State<SignInPage> {

  bool obserText = true;

  TextEditingController userEmail = new TextEditingController();
  TextEditingController userPassword = new TextEditingController();

  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail.text.trim(), password: userPassword.text.trim());
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Đăng nhập thành công",
            style: TextStyle(fontSize: 20.0),
          ))));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Email người dùng không tồn tại",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Nhập sai mật khẩu",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Đăng Nhập",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 350,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: userEmail,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Bạn chưa nhập email";
                          }else if(!regExp.hasMatch(value)){
                            return "Chưa nhập đúng định dạng email";
                          }
                          else return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      TextFormField(
                        controller: userPassword,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Bạn chưa nhập mật khẩu";
                          }else if(value.length < 6){
                            return "Mật khẩu phải dài hơn 6 ký tự";
                          }
                          else return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obserText = !obserText;
                              });
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(obserText == true ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                          ),
                        ),
                        obscureText: obserText,
                      ),
                      Container(
                        height: 40,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => ResetPassword(),)
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text("Quên mật khẩu?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                              ),
                            )
                        ),
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 3/5,
                        child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                setState(() {});
                              }
                              signIn();
                            },
                            child: Text(
                              "Đăng Nhập",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            )
                        ),
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 3/5,
                        child: ElevatedButton(
                            onPressed: widget.onPress,
                            child: Text(
                              "Đăng Ký",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
