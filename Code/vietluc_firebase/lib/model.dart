import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class SinhVien{
  String id, ngay_sinh, que_quan, ten;


  SinhVien({required this.id, required this.ngay_sinh, required this.que_quan, required this.ten});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ngay_sinh': this.ngay_sinh,
      'que_quan': this.que_quan,
      'ten': this.ten,
    };
  }

  factory SinhVien.fromJson(Map<String, dynamic> map) {
    return SinhVien(
      id: map['id'] as String,
      ngay_sinh: map['ngay_sinh'] as String,
      que_quan: map['que_quan'] as String,
      ten: map['ten'] as String,
    );
  }
}

class SinhVienSnapshot{
  SinhVien sv;
  DocumentReference docRef;

  SinhVienSnapshot({required this.sv, required this.docRef});


  factory SinhVienSnapshot.fromSnapShot(DocumentSnapshot docSnap) {
    return SinhVienSnapshot(
      sv: SinhVien.fromJson(docSnap.data() as Map<String, dynamic>),
      docRef: docSnap.reference
    );
  }
  static Stream<List<SinhVienSnapshot>> getALL(){
    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("SinhVien").snapshots();
    return querySnapshot.map(
      //Lấy document Snapshot
      (querySnapshot) => querySnapshot.docs.map(
        (docsnap) => SinhVienSnapshot.fromSnapShot(docsnap)
    ).toList()
    );
  }
}