import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String id, ten, email;

  UserModel({required this.id, required this.ten, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'email': this.email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      ten: map['ten'] as String,
      email: map['email'] as String,
    );
  }
}

class UserSnapshot{
  UserModel user;
  DocumentReference reference;

  UserSnapshot({required this.user, required this.reference});


  factory UserSnapshot.fromMap(DocumentSnapshot docSnap) {
    return UserSnapshot(
      user: UserModel.fromJson(docSnap.data() as Map<String, dynamic>),
      reference: docSnap.reference,
    );
  }

  static Future<DocumentReference> themUser(UserModel user) async{
    return FirebaseFirestore.instance.collection("users").add(user.toJson());
  }
  static Stream<UserSnapshot> getUser(String id) {
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("users").where('id', isEqualTo: id).snapshots();
    return sqs.map((qs) {
      if(qs.docs.isNotEmpty){
        return UserSnapshot.fromMap(qs.docs.first);
      }else{
        throw Exception('User not found');
      }
    },);
  }

  static Future<UserSnapshot> getUser1(String id) async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("users").where('id', isEqualTo: id).get();
    if(qs.docs.isNotEmpty){
      return UserSnapshot.fromMap(qs.docs.first);
    }else{
      throw Exception('Không tìm thấy người dùng');
    }
  }
}