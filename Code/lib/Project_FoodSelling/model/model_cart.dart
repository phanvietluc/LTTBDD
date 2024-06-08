import 'package:cloud_firestore/cloud_firestore.dart';

class Cart{
  String idUser, tenUser, email, tenSP, anhsp;
  int sl, tong;
  String trangthai;

  Cart({required this.idUser, required this.tenUser, required this.email, required this.tenSP, required this.anhsp, required this.sl,
      required this.tong, required this.trangthai});

  Map<String, dynamic> toJson() {
    return {
      'idUser': this.idUser,
      'tenUser': this.tenUser,
      'email': this.email,
      'tenSP': this.tenSP,
      'anhsp': this.anhsp,
      'sl': this.sl,
      'tong': this.tong,
      'trangthai': this.trangthai,
    };
  }

  factory Cart.fromJson(Map<String, dynamic> map) {
    return Cart(
      idUser: map['idUser'] as String,
      tenUser: map['tenUser'] as String,
      email: map['email'] as String,
      tenSP: map['tenSP'] as String,
      anhsp: map['anhsp'] as String,
      sl: map['sl'] as int,
      tong: map['tong'] as int,
      trangthai: map['trangthai'] as String,
    );
  }
}

class CartSnapshot{
  Cart cart;
  DocumentReference reference;

  CartSnapshot({required this.cart, required this.reference});

  factory CartSnapshot.fromMap(DocumentSnapshot docSnap) {
    return CartSnapshot(
      cart: Cart.fromJson(docSnap.data() as Map<String, dynamic>),
      reference: docSnap.reference,
    );
  }

  static Future<DocumentReference> themOrder(Cart cart) async{
    return FirebaseFirestore.instance.collection("orders").add(cart.toJson());
  }

  static Future<void> updateStatusPr(String id) async{
    return await FirebaseFirestore.instance.collection('orders').doc(id).update({"trangthai": "Đã giao"});
  }

  static Stream<List<CartSnapshot>> getOrder(String id) {
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("orders").where("idUser", isEqualTo: id).snapshots();
    return sqs.map(
      (qs) => qs.docs.map(
        (docSnap) => CartSnapshot.fromMap(docSnap),
      ).toList(),
    );
  }
  static Stream<List<CartSnapshot>> getAllOrder() {
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("orders").where('trangthai', isEqualTo: "Đang giao hàng").snapshots();
    return sqs.map(
          (qs) => qs.docs.map(
            (docSnap) => CartSnapshot.fromMap(docSnap),
      ).toList(),
    );
  }
}