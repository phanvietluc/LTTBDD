import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viet_luc63132246_flutter/Project_FoodSelling/database/shared_references.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  String? name, email, password;
  TextEditingController txtPassword = TextEditingController();
  bool isEditingPassword = false;

  bool obserText = true;
  @override
  void initState() {
    super.initState();
    onThisLoad();
  }

  getTheSharedPref() async {
    name = await SharedReference().getUserName();
    email = await SharedReference().getUserEmail();
    password = await SharedReference().getUserPassword();
    setState(() {
      txtPassword.text = password ?? '';
    });
  }

  onThisLoad() async {
    await getTheSharedPref();
  }
  updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && txtPassword.text.isNotEmpty) {
      try {
        await user.updatePassword(txtPassword.text);
        await SharedReference().saveUserPassword(txtPassword.text);
        setState(() {
          password = txtPassword.text;
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
                profileInfoCard(Icons.password, "Password", password),
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
                    isEditingPassword && title == "Password" ?
                    TextField(
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
                          child: Icon(obserText == true ? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                        ),
                      ),
                    ): Text(
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
