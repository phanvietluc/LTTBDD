import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase{

  Future addUserDetail(Map<String, dynamic> userInfo, String id) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfo);
  }

  Future<Stream<QuerySnapshot>> getOrder(String id) async{
    return await FirebaseFirestore.instance.collection('orders').where("idUser", isEqualTo: id).snapshots();
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