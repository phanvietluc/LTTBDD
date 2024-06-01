import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserController {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  void signIn(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail.text.trim(), password: userPassword.text.trim());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Lỗi khi đăng nhập"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  void signUp(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail.text.trim(), password: userPassword.text.trim()).then(
          (value) {
            String userId = value.user!.uid;
            _addUserToFirestore(userId);
          },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Lỗi khi đăng ký"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  void signOut(context) async{
    FirebaseAuth.instance.signOut();
  }
  _clearControllers() {
    userName.clear();
    userEmail.clear();
    userPassword.clear();
  }



  _addUserToFirestore(String userId) {
    FirebaseFirestore.instance.collection("users").doc(userId).set({
      "name": userName.text.trim(),
      "id": userId,
      "email": userEmail.text.trim(),
      "password": userPassword.text.trim()
    });
  }
  Future<Stream<QuerySnapshot>> getOrder(String email) async{
    return await FirebaseFirestore.instance.collection('orders').where("email", isEqualTo: email).snapshots();
  }

  Future<Stream<QuerySnapshot>> geAllOrder() async{
    return await FirebaseFirestore.instance.collection('orders').where("trangthai", isEqualTo: "Đang giao hàng").snapshots();
  }

  Future addOrderDetail(Map<String, dynamic> orderInfo) async{
    return await FirebaseFirestore.instance.collection('orders').add(orderInfo);
  }

  updateStatusPr(String id) async{
    return await FirebaseFirestore.instance.collection('orders').doc(id).update({"trangthai": "Đã giao"});
  }
}