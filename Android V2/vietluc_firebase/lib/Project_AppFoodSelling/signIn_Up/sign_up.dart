import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vietluc_firebase/Project_AppFoodSelling/controller/user_controller.dart';
import 'package:vietluc_firebase/Project_AppFoodSelling/signIn_Up/sign_in.dart';
class SignUpPage extends StatelessWidget {
  UserController userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Đăng Ký",
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
                          TextField(
                            controller: userController.userName,
                            decoration: InputDecoration(
                              labelText: "Tên",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          TextField(
                            controller: userController.userEmail,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          TextField(
                            controller: userController.userPassword,
                            decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              prefixIcon: Icon(Icons.password),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 3/5,
                            child: ElevatedButton(
                                onPressed: () {
                                  if(userController.userEmail != "" && userController.userPassword != ""){
                                    userController.signUp(context);
                                  }
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
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => SignInPage(),),
                                    (route) => false
                                  );
                                },
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
            ],
          )
      ),
    );;
  }
}
