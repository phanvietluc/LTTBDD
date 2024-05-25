import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/myWidget/custom_text.dart';

import '../../widget/snackbar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController userEmail = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    userEmail.dispose();
    super.dispose();
  }

  Future _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail.text);
      showmySnackBar(context,
          "Yêu cầu đã được gửi vào mail",
          3
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showmySnackBar(context,
            "Tài khoản không tồn tại",
            3
        );
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
                  text: "Tạo lại mật khẩu",
                  weight: FontWeight.bold,
                  size: 25,
                ),
                SizedBox(height: 40,),
                TextFormField(
                  controller: userEmail,
                  validator: (value){
                    if(value==null|| value.isEmpty){
                      return 'Vui lòng nhập Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 50.0,),
                GestureDetector(
                  onTap: () {
                    _resetPassword();
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
                          text: "Tạo lại mật khẩu",
                          size: 15,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
