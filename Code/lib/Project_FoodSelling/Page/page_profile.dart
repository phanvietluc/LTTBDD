import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  String? name, email;
  TextEditingController txtPassword = TextEditingController();
  bool isEditingPassword = false;

  bool obserText = true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }


  getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          var userData = userDoc.data();
          setState(() {
            name = userData?['name'];
            email = userData?['email'];
            txtPassword.text = userData?['password']; // Masking the password as it should not be directly accessible
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && txtPassword.text.isNotEmpty) {
      try {
        await user.updatePassword(txtPassword.text);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'password': txtPassword.text,
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green,),
                Text("Thay đổi mật khẩu thành công")
              ],
            ),
          ),
        );
        setState(() {
          isEditingPassword = false;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY PROFILE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 100),
            child: Column(
              children: [
                profileInfoCard(Icons.person, "Tên người dùng", name),
                SizedBox(height: 30.0),
                profileInfoCard(Icons.email, "Email", email),
                SizedBox(height: 30.0),
                profileInfoCard(Icons.password, "Password", '********'), // Masking the password
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileInfoCard(IconData icon, String title, String? value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Icon(icon, color: Colors.black),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    isEditingPassword && title == "Password"
                        ? TextField(
                      controller: txtPassword,
                      obscureText: obserText,
                      decoration: InputDecoration(
                        hintText: "Nhập mật khẩu mới",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obserText = !obserText;
                            });
                            FocusScope.of(context).unfocus();
                          },
                          child: Icon(
                            obserText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                        : Text(
                      value ?? 'Loading...',
                      style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              if (title == "Password")
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (title == "Password") {
                          isEditingPassword = !isEditingPassword;
                          if (!isEditingPassword) updatePassword();
                        }
                      });
                    },
                    icon: Icon(isEditingPassword && title == "Password" ? Icons.save : Icons.edit),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
