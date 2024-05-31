import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/shared_references.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/userdatabase.dart';
class SignUpPage extends StatefulWidget {
  final Function()? onPress;
  const SignUpPage({super.key, required this.onPress});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool obserText = true;
  String email = "", name = "", password = "";
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  void signUp() async{
    if(password != null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Đăng ký thành công",
              style: TextStyle(fontSize: 20.0),
            ))));
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "name": userName.text,
          "email": userEmail.text,
          "id": Id,
        };
        await UserDatabase().addUserDetail(addUserInfo, Id);
        await SharedReference().saveUserName(userName.text);
        await SharedReference().saveUserEmail(userEmail.text);
        await SharedReference().saveUserPassword(userPassword.text);
        await SharedReference().saveUserId(Id);
        //Navigator.pop(context, true);//Sau khi đăng ký xong sẽ hiện trên drawer trong trang chính
      }on FirebaseException catch (e) {
        if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                "Email đã được sử dụng",
                style: TextStyle(fontSize: 18.0),
              )));
        }
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
                        "Đăng ký",
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
                  height: 400,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: userName,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Bạn chưa nhập dữ liệu";
                          }else return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Tên",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
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
                        height: 45,
                        width: MediaQuery.of(context).size.width * 3/5,
                        child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  name = userName.text;
                                  email = userEmail.text;
                                  password = userPassword.text;
                                });
                              }
                              signUp();
                            },
                            child: Text(
                              "Đăng Ký",
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
                              "Đăng Nhập",
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