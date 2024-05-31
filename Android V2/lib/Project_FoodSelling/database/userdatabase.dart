import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase{
  Future addUserDetail(Map<String, dynamic> userInfo, String id) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfo);
  }

  Future<Stream<QuerySnapshot>> getOrder(String email) async{
    return await FirebaseFirestore.instance.collection('orders').where("email", isEqualTo: email).snapshots();
  }

  Future<Stream<QuerySnapshot>> geAllOrder() async{
    return await FirebaseFirestore.instance.collection('orders').where("trangthai", isEqualTo: "Đang giao hàng").snapshots();
  }

  Future<Stream<QuerySnapshot>> getUser(String email) async{
    return await FirebaseFirestore.instance.collection('users').where("email", isEqualTo: email).snapshots();
  }

  Future addOrderDetail(Map<String, dynamic> orderInfo) async{
    return await FirebaseFirestore.instance.collection('orders').add(orderInfo);
  }

  updateStatusPr(String id) async{
    return await FirebaseFirestore.instance.collection('orders').doc(id).update({"trangthai": "Đã giao"});
  }
}