import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/model/model_user.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  String? name, email;
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtCurrentPassword = TextEditingController();
  bool isEditingPassword = false;
  bool obserText = true;
  bool currentObserText = true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        var userDoc = await UserSnapshot.getUser1(user.uid);
        setState(() {
          email = userDoc.user.email;
          name = userDoc.user.ten;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  reauthenticateUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: txtCurrentPassword.text
      );

      try {
        await user.reauthenticateWithCredential(credential);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text("Xác thực thành công"),
              ],
            ),
          ),
        );
        setState(() {
          isEditingPassword = true;
        });
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Text("Xác thực thất bại"),
              ],
            ),
          ),
        );
      }
    }
  }

  updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && txtPassword.text.isNotEmpty) {
      try {
        await user.updatePassword(txtPassword.text);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text("Thay đổi mật khẩu thành công"),
              ],
            ),
          ),
        );
        setState(() {
          isEditingPassword = false;
        });
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Text("Không thể thay đổi mật khẩu"),
              ],
            ),
          ),
        );
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
                profileInfoCard(Icons.password, "Password", '********'),
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
                    isEditingPassword && title == "Password" ? TextField(
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
                      if (isEditingPassword) {
                        updatePassword();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Xác thực người dùng"),
                            content: TextField(
                              controller: txtCurrentPassword,
                              obscureText: currentObserText,
                              decoration: InputDecoration(
                                hintText: "Nhập mật khẩu hiện tại",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentObserText = !currentObserText;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Icon(
                                    currentObserText ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Hủy"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  reauthenticateUser();
                                },
                                child: Text("Xác thực"),
                              ),
                            ],
                          ),
                        );
                      }
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
